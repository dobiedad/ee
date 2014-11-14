#import <Foundation/Foundation.h>

@interface FirebaseClient : NSObject

-(void)saveLinkedInProfileWithId:(NSString*)id andProfile:(NSDictionary*)profile;
- (void)matchesForUser:(NSString *)userId withBlock:(void (^)(NSArray *))block;


@end
