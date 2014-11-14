#import "FirebaseClient.h"
#import "LinkedInProfile.h"
#import <Firebase/Firebase.h>

@implementation FirebaseClient {
    NSMutableArray *_results;
}

-(void)saveLinkedInProfileWithId:(NSString*)id andProfile:(NSDictionary*)profile {
    NSString *path = [NSString stringWithFormat:@"users/%@/linkedInProfile", id];
    Firebase *firebase = [self firebaseForPath:path];
    [firebase setValue:profile];
}

- (void)matchesForUser:(NSString *)userId withBlock:(void (^)(NSArray *))block {
    NSString *path = [NSString stringWithFormat:@"matches/%@", userId];
    Firebase *matchesRoot = [self firebaseForPath:path];
    FQuery* matchesQuery = [matchesRoot queryLimitedToNumberOfChildren:10];

    [matchesQuery observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self getProfilesForMatches:snapshot block:block];
    }];
}



- (void)getProfilesForMatches:(FDataSnapshot *)snapshot block:(void (^)(NSArray *))block {
    _results = [[NSMutableArray alloc] init];
    
    NSString *theirProfilePath = [NSString stringWithFormat:@"users/%@/linkedInProfile", snapshot.name];
    Firebase *theirProfileFirebase = [self firebaseForPath:theirProfilePath];
    unsigned long matchCount = (unsigned long)[snapshot childrenCount] - 1;
    
    [theirProfileFirebase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *theirProfileSnapshot) {
        LinkedInProfile *theirLinkedInProfile = [[LinkedInProfile alloc] initWithLinkedInApiUserData:theirProfileSnapshot.value];
        [_results addObject:theirLinkedInProfile];
        if (_results.count == matchCount) {
            block(_results);
        }
    }];
}

- (Firebase *)firebaseForPath:(NSString *)path {
    NSString *rootUrl = @"https://incandescent-inferno-9409.firebaseio.com/";
    NSString *fullUrl = [rootUrl stringByAppendingString:path];
    return [[Firebase alloc] initWithUrl:fullUrl];
}
@end
