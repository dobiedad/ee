#import <Foundation/Foundation.h>

@interface LinkedInProfile : NSDictionary
- (instancetype)initWithLinkedInApiUserData:(NSDictionary *)data;
- (NSString *)linkedInUserId;
- (NSString *)firstName;
- (NSString *)companyName;
- (NSURL *)pictureURL;
- (NSString *)lastSchoolName;
- (NSString *)fieldOfStudy;
- (NSString *)industry;
- (NSDictionary *)asDictionary;
@end
