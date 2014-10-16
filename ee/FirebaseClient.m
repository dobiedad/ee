#import "FirebaseClient.h"
#import <Firebase/Firebase.h>

@implementation FirebaseClient

-(void)saveLinkedInProfileWithId:(NSString*)id andProfile:(NSDictionary*)profile {
    NSString *profileUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/users/%@/linkedInProfile", id];
    Firebase* firebase = [[Firebase alloc] initWithUrl:profileUrl];
    [firebase setValue:profile];
}

@end
