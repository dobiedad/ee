#import "MainController.h"
#import "LinkedInProfile.h"
#import "TLYShyNavBarManager.h"
#import <UIView+MTAnimation.h>

@interface MainController ()
@end

@implementation MainController {
    LinkedInProfile *_profile;

}


@synthesize scrollView;
@synthesize matchesContainer;
@synthesize profileContainer;
@synthesize chatContainer;

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
    
    if (scrollView.contentOffset.x == self.profileContainer.frame.origin.x) {
        [UIView mt_animateWithViews:@[profileContainer]
                           duration:0.1
                     timingFunction:kMTEaseOutQuad
                         animations:^{
                             CGRect r             = profileContainer.frame;
                             r.origin.x           = 50;
                             profileContainer.frame = r;
                         }
                         completion:^{
                             [UIView mt_animateWithViews:@[profileContainer]
                                                duration:0.1
                                          timingFunction:kMTEaseInQuad
                                              animations:^{
                                                  CGRect r             = profileContainer.frame;
                                                  r.origin.x           = 0 ;
                                                  profileContainer.frame = r;
                                              }
                              ];
                         }
         ];
        
    }
    else{
        [scrollView scrollRectToVisible:(self.profileContainer.frame) animated:true];
    }

}

- (IBAction)chatButtonClicked:(id)sender {
    
    if (scrollView.contentOffset.x == self.chatContainer.frame.origin.x) {
        
        CGFloat originX = chatContainer.frame.origin.x;
        
        [UIView mt_animateWithViews:@[chatContainer]
                           duration:0.1
                     timingFunction:kMTEaseOutQuad
                         animations:^{
                             CGRect r             = chatContainer.frame;
                             r.origin.x           = originX - 50;
                             chatContainer.frame = r;
                         }  
                         completion:^{
                             [UIView mt_animateWithViews:@[chatContainer]
                                                duration:0.1
                                          timingFunction:kMTEaseInQuad
                                              animations:^{
                                                  CGRect r             = chatContainer.frame;
                                                  r.origin.x           = originX;
                                                  chatContainer.frame = r;
                                              }
                              ];
                         }
         ];
        
    }
    else{
        [scrollView scrollRectToVisible:(self.chatContainer.frame) animated:true];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setProfile: (LinkedInProfile*) profile {
    _profile = profile;
}

@end
