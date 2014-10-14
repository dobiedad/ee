#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GeoFire/GeoFire.h>

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *signinButton;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniCourseLabel;

@end

