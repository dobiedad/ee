#import "LinkedInClient.h"
#import "AFHTTPRequestOperation.h"
#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"

@implementation LinkedInClient

- (void)attemptToSignInFromSavedTokenWithSuccess:(void (^)(LinkedInProfile *linkedInProfile))signedInBlock andNoSavedToken:(void (^)())noSavedTokenBlock {
    NSString *savedAccessToken = [self getSavedAccessToken];
    if (savedAccessToken == nil) {
        noSavedTokenBlock();
    } else {
        [self getLinkedInProfileWithAccessToken: savedAccessToken withSuccess: signedInBlock];
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

- (void)getLinkedInProfileWithAccessToken:(NSString *)accessToken withSuccess:(void (^)(LinkedInProfile *linkedInProfile))profileBlock {
    [self requestMeWithToken:accessToken andCallBlockWithProfile:profileBlock];
}

- (void)showLinkedInSignIn:(void (^)(LinkedInProfile *linkedInProfile))signedInBlock {
    [self.httpClient getAuthorizationCode:^(NSString *code) {
        [self.httpClient getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = accessTokenData[@"access_token"];
            [self saveAccessToken:accessToken];
            [self requestMeWithToken:accessToken andCallBlockWithProfile:signedInBlock];

        }                       failure:^(NSError *error) {
            NSLog(@"Quering accessToken failed %@", error);
        }];
    }                              cancel:^{
        NSLog(@"Authorization was cancelled by user");
    }                             failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
    }];
}

- (void)requestMeWithToken:(NSString *)accessToken andCallBlockWithProfile:(void (^)(LinkedInProfile *linkedInProfile))profileBlock {
    NSString *url = [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(location:(name),first-name,last-name,industry,picture-urls::(original),picture-url,id,positions:(is-current,company:(name)),educations:(school-name,field-of-study,start-date,end-date,degree,activities))?oauth2_access_token=%@&format=json", accessToken];
    
    [self.httpClient GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, LinkedInProfile *linkedInProfile) {

        NSString *linkedInUserId = [linkedInProfile objectForKey:@"id"];
        [self saveLinkedInId:linkedInUserId];

        NSLog(@"current user %@", linkedInProfile);

        profileBlock(linkedInProfile);

    }            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
    }];
}

- (void)saveLinkedInId:(NSString *)linkedInUserId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:linkedInUserId forKey:@"linkedInUserId"];
    [defaults synchronize];
}

- (LIALinkedInHttpClient *)httpClient {
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"https://dizzolve.herokuapp.com"
        clientId:@"77ayafcrxmygv3"
    clientSecret:@"TRgPPRLgnsWtwBiL"
           state:@"DCEEFWF45453sdffef424"
   grantedAccess:@[@"r_fullprofile", @"r_network",@"r_emailaddress",@"rw_company_admin",@"r_contactinfo",@"rw_nus",]];
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
}


@end