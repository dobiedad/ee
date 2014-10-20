#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GeoFire/GeoFire.h>
#import "LinkedInProfile.h"
#import "FXBlurView.h"


@interface ProfileController : UIViewController

-(void)setProfile: (LinkedInProfile*) profile;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniCourseLabel;
@property (weak, nonatomic) IBOutlet FXBlurView *profileBlurView;
@property (weak, nonatomic) IBOutlet FXBlurView *profileBlurView1;
@property (weak, nonatomic) IBOutlet FXBlurView *profileBlurView2;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundView;

@end

