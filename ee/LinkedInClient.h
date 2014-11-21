#import <Foundation/Foundation.h>
#import "LinkedInProfile.h"

@interface LinkedInClient : NSObject

- (void)attemptToSignInFromSavedTokenWithSuccess:(void (^)(LinkedInProfile *linkedInProfile))signedInBlock andNoSavedToken:(void (^)())noSavedTokenBlock;

- (void)showLinkedInSignIn:(void (^)(LinkedInProfile *linkedInProfile))signedInBlock orWhenCancelled:(void (^)())cancelledBlock;

- (void)getLogoUrlForCompanyId: (NSString *)companyId andCallBlockWithURL:(void (^)(NSURL *url))urlBlock;

@end
