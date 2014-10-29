#import "MainController.h"
#import "LinkedInProfile.h"

@interface MainController ()
@end

@implementation MainController {
    LinkedInProfile *_profile;
}


@synthesize scrollView;
@synthesize matchesContainer;
@synthesize profileContainer;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

   
    NSLog(@"%lu", self.childViewControllers.count);
    
    for (UIViewController *viewController in self.childViewControllers)
    {
        if ([viewController respondsToSelector:@selector(setProfile:)]) {
            [viewController performSelector:@selector(setProfile:) withObject:_profile];
        }
    }
}
- (IBAction)profileButtonClicked:(id)sender {
    [scrollView scrollRectToVisible:(self.profileContainer.frame) animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setProfile: (LinkedInProfile*) profile {
    _profile = profile;
}

@end
