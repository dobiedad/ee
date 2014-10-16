#import <Foundation/Foundation.h>

@interface FirebaseClient : NSObject

-(void)saveLinkedInProfileWithId:(NSString*)id andProfile:(NSDictionary*)profile;

@end
