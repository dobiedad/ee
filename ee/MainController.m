#import "MainController.h"
#import "LinkedInProfile.h"

@interface MainController ()
@end

@implementation MainController {
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setProfile: (LinkedInProfile*) profile {
    for (UIViewController *viewController in self.viewControllers)
    {
        if ([viewController respondsToSelector:@selector(setProfile:)]) {
            [viewController performSelector:@selector(setProfile:) withObject:profile];
        }
    }
}

@end
