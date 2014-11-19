#import "LinkedInProfile.h"

@implementation LinkedInProfile {
    NSDictionary *_dictionary;
}

- (instancetype)initWithLinkedInApiUserData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        _dictionary = data;
        NSLog(@"%@", data);
    }
    return self;
}

- (NSString *)linkedInUserId {
    return _dictionary[@"id"];
}

- (NSString *)companyName {
    return _dictionary[@"positions"][@"values"][0][@"company"][@"name"];
}

- (NSURL *)pictureURL {
    return [NSURL URLWithString: _dictionary[@"pictureUrls"][@"values"][0]];
}

- (NSDictionary *)asDictionary {
    return _dictionary;
}

- (NSString *)lastSchoolName {
    return _dictionary[@"educations"][@"values"][0][@"schoolName"];
}

- (NSString *)fieldOfStudy {
    return _dictionary[@"educations"][@"values"][0][@"fieldOfStudy"];
}

- (NSString *)industry {
    return _dictionary[@"industry"];
}

- (NSString *)firstName {
    return _dictionary[@"firstName"];
}

- (NSUInteger)connections {
    return [_dictionary [@"numConnections"] integerValue];
}
- (NSString *)companyId {
    return _dictionary[@"positions"][@"values"][0][@"company"][@"id"];
}
@end
