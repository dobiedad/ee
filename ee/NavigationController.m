#import "NavigationController.h"
#import "LinkedInProfile.h"

@implementation NavigationController
-(void)setProfile: (LinkedInProfile*) profile {
    if ([self.topViewController respondsToSelector:@selector(setProfile:)]) {
        [self.topViewController performSelector:@selector(setProfile:) withObject:profile];
    }
}

@end
