#import <Foundation/Foundation.h>

@interface LinkedInClient : NSObject

- (void)attemptToSignInFromSavedTokenWithSuccess:(void (^)(NSDictionary *linkedInProfile))signedInBlock andNoSavedToken:(void (^)())noSavedTokenBlock;

- (void)showLinkedInSignIn:(void (^)(NSDictionary *linkedInProfile))signedInBlock;

@end
