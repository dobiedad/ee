//
//  FirstViewController.m
//  ee
//
//  Created by Leo Mdivani on 02/10/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import "FirstViewController.h"
#import "LIALinkedInApplication.h"
#import "LIALinkedInHttpClient.h"



@interface FirstViewController ()

@end

@implementation FirstViewController
LIALinkedInHttpClient *_client;
- (void)viewDidLoad {
    [super viewDidLoad];
    _client = [self client];
    self.view.backgroundColor = [UIColor whiteColor];
    _signinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_signinButton setTitle:@"Request token" forState:UIControlStateNormal];
    _signinButton.frame = CGRectMake(0, 0, 200, 44);
    _signinButton.center = self.view.center;
    [self.view addSubview:_signinButton];
    [_signinButton addTarget:self action:@selector(didRequestAuthToken) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _signinButton.center = self.view.center;
}


- (void)didRequestAuthToken {
    
    if ([_client validToken]) {
        [self requestMeWithToken:[_client accessToken]];
    } else {
        [_client getAuthorizationCode:^(NSString *code) {
            [self.client getAccessToken:code success:^(NSDictionary *accessTokenData) {
                NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
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
}

- (void)requestMeWithToken:(NSString *)accessToken {
    [self.client GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
        NSLog(@"current user %@", result);
    }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
    }];
}

- (LIALinkedInHttpClient *)client {
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.ancientprogramming.com/liaexample"
                                                                                    clientId:@"77ayafcrxmygv3"
                                                                                clientSecret:@"TRgPPRLgnsWtwBiL"
                                                                                       state:@"DCEEFWF45453sdffef424"
                                                                               grantedAccess:@[@"r_fullprofile", @"r_network"]];
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
