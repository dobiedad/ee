#import "MainController.h"
#import "LinkedInProfile.h"

@interface MainController ()
@end

@implementation MainController {
}


@synthesize scrollView;
@synthesize matchesContainer;
@synthesize profileContainer;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled = YES;
    
    self.profileContainer.frame = CGRectMake(
        self.scrollView.frame.size.width * 0, 0.f, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    self.matchesContainer.frame = CGRectMake(self.scrollView.frame.size.width * 1, 0.f,
                                             self.scrollView.frame.size.width, self.scrollView.frame.size.height);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setProfile: (LinkedInProfile*) profile {
//    for (UIViewController *viewController in self.viewControllers)
//    {
//        if ([viewController respondsToSelector:@selector(setProfile:)]) {
//            [viewController performSelector:@selector(setProfile:) withObject:profile];
//        }
//    }
}

@end
