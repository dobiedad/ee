#import "LinkedInClient.h"
#import "AFHTTPRequestOperation.h"
#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"

@implementation LinkedInClient

- (void)attemptToSignInFromSavedTokenWithSuccess:(void (^)(NSDictionary *linkedInProfile))signedInBlock andNoSavedToken:(void (^)())noSavedTokenBlock {
    NSString *savedAccessToken = [self getSavedAccessToken];
    if (savedAccessToken == nil) {
        noSavedTokenBlock();
    } else {
        [self getLinkedInProfileWithAccessToken: savedAccessToken withSuccess: signedInBlock];
    }
}

- (LIALinkedInHttpClient *)client {
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"https://dizzolve.herokuapp.com"
        clientId:@"77ayafcrxmygv3"
        clientSecret:@"TRgPPRLgnsWtwBiL"
        state:@"DCEEFWF45453sdffef424"
        grantedAccess:@[@"r_fullprofile", @"r_network",@"r_emailaddress",@"rw_company_admin",@"r_contactinfo",@"rw_nus",]];
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
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

- (void)getLinkedInProfileWithAccessToken:(NSString *)accessToken withSuccess:(void (^)(NSDictionary *linkedInProfile))profileBlock {

}

@end