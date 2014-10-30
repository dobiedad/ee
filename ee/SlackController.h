#import "SLKTextViewController.h"
#import "LinkedInProfile.h"

@interface SlackController : SLKTextViewController

-(void)setProfile: (LinkedInProfile*) profile;
-(void)setOtherUsersProfile: (LinkedInProfile*) profile;

@end
