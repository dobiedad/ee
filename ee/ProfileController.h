#import <UIKit/UIKit.h>
#import "LinkedInProfile.h"
#import "RKCardView.h"

@interface ProfileController : UIViewController< UITextFieldDelegate>

-(void)setProfile: (LinkedInProfile*) profile;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundView;
@property (weak, nonatomic) IBOutlet UITextView *aboutMeTextView;
@property (weak, nonatomic) IBOutlet UIView *chatButtonView;
@property (weak, nonatomic) IBOutlet UIView *friendButtonView;
@property (weak, nonatomic) IBOutlet UIScrollView *profileScrollView;
@property (weak, nonatomic) IBOutlet UITextView *linksTextView;

@end

