#import <UIKit/UIKit.h>
#import "LinkedInProfile.h"

@interface MainController : UIViewController

-(void)setProfile: (LinkedInProfile*) profile;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *profileContainer;
@property (weak, nonatomic) IBOutlet UIView *matchesContainer;
@property (weak, nonatomic) IBOutlet UIView *chatContainer;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
