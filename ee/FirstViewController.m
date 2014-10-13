#import "FirstViewController.h"
#import "AFHTTPRequestOperation.h"
#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"
#import <Firebase/Firebase.h>

@interface FirstViewController () <CLLocationManagerDelegate>
@end


@implementation FirstViewController {
    LIALinkedInHttpClient *_client;
}
@synthesize profilePicImageView;
@synthesize signinButton;
@synthesize industryLabel;
@synthesize jobLabel;
@synthesize uniCourseLabel;
@synthesize uniNameLabel;
@synthesize firstNameLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocationManager];
    NSString *accessToken = [self getSavedAccessToken];
    if (accessToken != nil) {
        [self requestMeWithToken:accessToken];
        signinButton.hidden=true;
    }
}


- (void)startLocationManager {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        NSLog(@"Location services enabled!");
    } else {
        NSLog(@"Location services are not enabled");
    }
}

- (NSString *)getSavedAccessToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults objectForKey:@"accessToken"];
    return accessToken;
}

- (void)saveAccessToken:(NSString *)accessToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"accessToken"];
    [defaults synchronize];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *linkedInUserId = [defaults objectForKey:@"linkedInUserId"];

//    NSDate *timeNow =[NSDate date];
//    NSString *latLongUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/%@/locations/%@",  linkedInUserId,timeNow];
//    Firebase* myRootRef = [[Firebase alloc] initWithUrl:latLongUrl];
//    NSNumber *lat = [NSNumber numberWithDouble:location.coordinate.latitude];
//    NSNumber *lng = [NSNumber numberWithDouble:location.coordinate.longitude];
//    NSDictionary *LatLongDictionary = [NSDictionary dictionaryWithObjects:@[lat,lng] forKeys:@[@"lat",@"long"]];
//    [myRootRef setValue:LatLongDictionary];

    Firebase* firebase = [[Firebase alloc] initWithUrl:@"https://incandescent-inferno-9409.firebaseio.com"];
    GeoFire *geoFire = [[GeoFire alloc] initWithFirebaseRef:firebase];
    [geoFire setLocation:[[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude]
                  forKey:@"levan-is-here"];

//    CLLocation *center = [[CLLocation alloc] initWithLatitude:37.7832889 longitude:-122.4056973];
//    // Query locations at [37.7832889, -122.4056973] with a radius of 600 meters
//    GFCircleQuery *circleQuery = [geoFire queryAtLocation:center withRadius:0.6];
//
//    FirebaseHandle queryHandle = [circleQuery observeEventType:GFEventTypeKeyEntered withBlock:^(NSString *key, CLLocation *location) {
//        NSLog(@"Key '%@' entered the search area and is at location '%@'", key, location);
//    }];
}

- (IBAction)didTapConnectWithLinkedIn:(id)sender {
    [self.client getAuthorizationCode:^(NSString *code) {
        [self.client getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
            [self saveAccessToken: accessToken];
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

- (void)requestMeWithToken:(NSString *)accessToken {
    NSString *url = [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(location:(name),first-name,last-name,industry,picture-url::(original),id,positions:(is-current,company:(name)),educations:(school-name,field-of-study,start-date,end-date,degree,activities))?oauth2_access_token=%@&format=json", accessToken];
    
    [self.client GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *linkedInData) {

        [self updateViewFromLinkedInData:linkedInData];

        NSString *linkedInUserId = [linkedInData objectForKey:@"id"];

        NSString *profileUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/%@/profiles", linkedInUserId];
        Firebase* myRootRef = [[Firebase alloc] initWithUrl:profileUrl];
        [myRootRef setValue:linkedInData];

        [self saveLinkedInId:linkedInUserId];

        for(NSString *data in [linkedInData allKeys]) {
//            NSLog(@"%@",[linkedInData objectForKey:data]);
        }
        
        NSLog(@"current user %@", linkedInData);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
    }];
}

- (void)updateViewFromLinkedInData:(NSDictionary *)linkedInData {
    NSString *profilePicURL = [linkedInData objectForKey:@"pictureUrl"];
    NSString *companyName = linkedInData[@"positions"][@"values"][0][@"company"][@"name"];
    NSString *lastSchoolName = linkedInData[@"educations"][@"values"][0][@"schoolName"];
    NSString *lastSchoolCourse = linkedInData[@"educations"][@"values"][0][@"fieldOfStudy"];

    NSString *industry = [linkedInData objectForKey:@"industry"];
    NSString *firstName = [linkedInData objectForKey:@"firstName"];

    industryLabel.text=industry;
    firstNameLabel.text=firstName;
    jobLabel.text=companyName;
    uniNameLabel.text= lastSchoolName;
    uniCourseLabel.text= lastSchoolCourse;

    profilePicImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
}

- (void)saveLinkedInId:(NSString *)linkedInUserId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:linkedInUserId forKey:@"linkedInUserId"];
    [defaults synchronize];
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
