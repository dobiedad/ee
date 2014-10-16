#import "FirebaseClient.h"
#import "LinkedInProfile.h"
#import <Firebase/Firebase.h>

@implementation FirebaseClient

-(void)saveLinkedInProfileWithId:(NSString*)id andProfile:(NSDictionary*)profile {
    NSString *profileUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/users/%@/linkedInProfile", id];
    Firebase* firebase = [[Firebase alloc] initWithUrl:profileUrl];
    [firebase setValue:profile];
}

- (void)matchesForUser:(NSString *)userId withBlock:(void (^)(NSArray *))block {
    Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/matches/%@", userId]];

    FQuery* matchesQuery = [ref queryLimitedToNumberOfChildren:10];

    NSMutableArray *results = [[NSMutableArray alloc] init];

    [matchesQuery observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {

        Firebase *theirProfile = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/users/%@/linkedInProfile", snapshot.name]];

        unsigned long matchCount = (unsigned long)[snapshot childrenCount] - 1;

        [theirProfile observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *theirProfileSnapshot) {
            LinkedInProfile *theirLinkedInProfile = [[LinkedInProfile alloc] initWithLinkedInApiUserData:theirProfileSnapshot.value];
            [results addObject:theirLinkedInProfile];
            if (results.count == matchCount) {
                block(results);
            }
        }];
    }];

}
@end
