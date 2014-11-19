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
        [self getLinkedInProfileWithAccessToken: savedAccessToken withSuccess: signedInBlock orWhenCancelled:noSavedTokenBlock];
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

- (void)getLinkedInProfileWithAccessToken:(NSString *)accessToken withSuccess:(void (^)(LinkedInProfile *linkedInProfile))profileBlock orWhenCancelled:(void (^)())cancelledBlock {
    [self requestMeWithToken:accessToken andCallBlockWithProfile:profileBlock orWhenCancelled: cancelledBlock];
}

- (void)showLinkedInSignIn:(void (^)(LinkedInProfile *linkedInProfile))signedInBlock orWhenCancelled:(void (^)())cancelledBlock {
    [self.httpClient getAuthorizationCode:^(NSString *code) {
        [self.httpClient getAccessToken:code success:^(NSDictionary *accessTokenData) {
            NSString *accessToken = accessTokenData[@"access_token"];
            [self saveAccessToken:accessToken];
            [self requestMeWithToken:accessToken andCallBlockWithProfile:signedInBlock orWhenCancelled:cancelledBlock];

        }                       failure:^(NSError *error) {
            NSLog(@"Quering accessToken failed %@", error);
            cancelledBlock();
        }];
    }                              cancel:^{
        NSLog(@"Authorization was cancelled by user");
        cancelledBlock();
        
    }                             failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
        cancelledBlock();
    }];
}

- (void)requestMeWithToken:(NSString *)accessToken andCallBlockWithProfile:(void (^)(LinkedInProfile *linkedInProfile))profileBlock orWhenCancelled:(void (^)())cancelledBlock {
    NSString *url = [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(location:(name),first-name,last-name,num-connections,industry,picture-urls::(original),picture-url,id,positions:(is-current,company:(name,id)),educations:(school-name,field-of-study,start-date,end-date,degree,activities))?oauth2_access_token=%@&format=json", accessToken];
    // NSLog(@"%@", accessToken);
    
    [self.httpClient GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *linkedInProfileData) {
        LinkedInProfile *profile = [[LinkedInProfile alloc] initWithLinkedInApiUserData:linkedInProfileData];
        NSString *linkedInUserId = [profile linkedInUserId];
        [self saveLinkedInId:linkedInUserId];
        profileBlock(profile);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
        [self showLinkedInSignIn:profileBlock orWhenCancelled:cancelledBlock];
    }];
}

- (NSURL *)getLogoUrlForCompanyId: (NSString *)companyId {
    NSString *accessToken = [self getSavedAccessToken];
    NSString *url = [NSString stringWithFormat:@"https://api.linkedin.com/v1/companies/%@:(logo-url)?oauth2_access_token=%@&format=json", companyId, accessToken];
    return [NSURL URLWithString:url];
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