//
//  FirstViewController.m
//  ee
//
//  Created by Leo Mdivani on 02/10/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import "FirstViewController.h"
#import "AFHTTPRequestOperation.h"
#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"
#import <Firebase/Firebase.h>






@interface FirstViewController () <CLLocationManagerDelegate>

@end


@implementation FirstViewController{
LIALinkedInHttpClient *_client;

}
@synthesize textview;


- (void)viewDidLoad {
    [super viewDidLoad];
    _client = [self client];
    [self showusersLinkedIn];
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        NSLog(@"Location services enabled!");
        
        
    } else {
        NSLog(@"Location services are not enabled");
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults objectForKey:@"accessToken"];
    if (accessToken != nil) {
        [self requestMeWithToken:accessToken];
    }




}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"%f", location.coordinate.latitude);
    NSLog(@"%f", location.coordinate.longitude);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *linkedInUserId = [defaults objectForKey:@"linkedInUserId"];

    NSDate *now =[NSDate date];
    
    NSString *latlongURL = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/locations/%@/%@",  linkedInUserId,now];
    
    Firebase* myRootRef = [[Firebase alloc] initWithUrl:latlongURL];
    
    NSNumber *lat = [NSNumber numberWithDouble:location.coordinate.latitude];
    NSNumber *lng = [NSNumber numberWithDouble:location.coordinate.longitude];
    NSDictionary *LatLongDictionary = [NSDictionary dictionaryWithObjects:@[lat,lng] forKeys:@[@"lat",@"long"]];
    
    [myRootRef setValue:LatLongDictionary];

    
    
}

- (IBAction)didTapConnectWithLinkedIn:(id)sender {
    [self.client getAuthorizationCode:^(NSString *code) {
        [self.client getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:accessToken forKey:@"accessToken"];
            [defaults synchronize];
            
            [self requestMeWithToken:accessToken];
        }                   failure:^(NSError *error) {
            NSLog(@"Quering accessToken failed %@", error);
        }];
    }                      cancel:^{
        NSLog(@"Authorization was cancelled by user");
    }                     failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
    }];
}
- (IBAction)getDataButtonClicked:(id)sender {
    
    [self showusersLinkedIn];
}


- (void)showusersLinkedIn{
    Firebase* myRootRef = [[Firebase alloc] initWithUrl:@"https://incandescent-inferno-9409.firebaseio.com"];

    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
    }];
}


- (void)requestMeWithToken:(NSString *)accessToken {
    NSString *url = [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(location:(name),first-name,last-name,industry,picture-url,id)?oauth2_access_token=%@&format=json", accessToken];
    
    [self.client GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
        
        NSString *linkedInUserId = [result objectForKey:@"id"];
        
        NSString *profileUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/profiles/%@", linkedInUserId];
        
        Firebase* myRootRef = [[Firebase alloc] initWithUrl:profileUrl];
        [myRootRef setValue:result];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:linkedInUserId forKey:@"linkedInUserId"];
        [defaults synchronize];
        
        
        for(NSString *data in [result allKeys]) {
            NSLog(@"%@",[result objectForKey:data]);
            [textview setText:data];
        }
        
        NSLog(@"current user %@", result);
    }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
    }];
}

- (LIALinkedInHttpClient *)client {
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"https://dizzolve.herokuapp.com"
                                                                                    clientId:@"77ayafcrxmygv3"
                                                                                clientSecret:@"TRgPPRLgnsWtwBiL"
                                                                                       state:@"DCEEFWF45453sdffef424"
                                                                               grantedAccess:@[@"r_fullprofile", @"r_network",@"r_emailaddress",@"rw_company_admin",@"r_contactinfo",@"rw_nus",]];
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
}



@end
