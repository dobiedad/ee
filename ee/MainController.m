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

    
    scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled = YES;
    
   
    
    
    
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
