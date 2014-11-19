#import <Foundation/Foundation.h>

@interface LinkedInProfile : NSObject
- (instancetype)initWithLinkedInApiUserData:(NSDictionary *)data;
- (NSString *)linkedInUserId;
- (NSString *)firstName;
- (NSString *)companyName;
- (NSURL *)pictureURL;
- (NSString *)lastSchoolName;
- (NSString *)fieldOfStudy;
- (NSString *)industry;
- (NSString *)companyId;
- (NSUInteger)connections;
- (NSDictionary *)asDictionary;
@end
