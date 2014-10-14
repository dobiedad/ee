#import <Foundation/Foundation.h>

@interface LinkedInClient : NSObject

- (void)attemptToSignInFromSavedTokenWithSuccess:(void (^)(NSDictionary *linkedInProfile))signedInBlock andNoSavedToken:(void (^)())noSavedTokenBlock;

@end
