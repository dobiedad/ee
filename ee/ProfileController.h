#import <UIKit/UIKit.h>
#import "LinkedInProfile.h"

@interface ProfileController : UIViewController< UITextFieldDelegate>

-(void)setProfile: (LinkedInProfile*) profile;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniCourseLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *infoScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundView;
@property (weak, nonatomic) IBOutlet UITextView *aboutMeTextView;

@end

