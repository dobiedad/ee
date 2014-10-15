#import "FirebaseClient.h"
#import <Firebase/Firebase.h>

@implementation FirebaseClient

-(void)saveLinkedInProfile:(NSDictionary*)profile {
    NSString *linkedInUserId = profile[@"id"];
    NSString *profileUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/users/%@/linkedInProfile", linkedInUserId];
    Firebase* firebase = [[Firebase alloc] initWithUrl:profileUrl];
    [firebase setValue:profile];
}

@end
