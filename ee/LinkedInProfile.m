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
    return [self company][@"name"];
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
- (NSUInteger)companyId {
    NSDictionary *company = [self company];
    id companyId = company[@"id"];
    return [companyId longValue];
}

-(NSDictionary *)company {
    return _dictionary[@"positions"][@"values"][0][@"company"];
}
@end
