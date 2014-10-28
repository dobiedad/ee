#import "ProfileController.h"

@interface ProfileController () <CLLocationManagerDelegate>
@end


@implementation ProfileController {
    GFCircleQuery *_geoQuery;
    LinkedInProfile *_profile;
}
@synthesize profilePicImageView;
@synthesize industryLabel;
@synthesize jobLabel;
@synthesize uniCourseLabel;
@synthesize uniNameLabel;
@synthesize firstNameLabel;

@synthesize profileBackgroundView;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateProfileDetailsInView];
    [self paralax];

    //[self startLocationManager];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.profileBackgroundView.bounds];
    blurView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.profileBackgroundView insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
    

    
    self.profilePicImageView.layer.cornerRadius = 100.0;
    [profilePicImageView setClipsToBounds:YES];
    self.profilePicImageView.layer.borderColor = [UIColor greenColor].CGColor;
    self.profilePicImageView.layer.borderWidth = 1.5;
    


}


- (void)paralax
{
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-30);
    verticalMotionEffect.maximumRelativeValue = @(30);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-30);
    horizontalMotionEffect.maximumRelativeValue = @(30);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [profilePicImageView addMotionEffect:group];
}


- (void)startLocationManager {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        NSLog(@"Location services enabled!");
    } else {
        NSLog(@"Location services are not enabled");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *linkedInUserId = [defaults objectForKey:@"linkedInUserId"];
    
    NSString *usersRootUrl = [NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/locations"];

    Firebase* firebase = [[Firebase alloc] initWithUrl:usersRootUrl];
    GeoFire *geoFire = [[GeoFire alloc] initWithFirebaseRef:firebase];
    
    [geoFire setLocation:location forKey:linkedInUserId];

    CLLocation *center = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    
    [_geoQuery removeAllObservers];
    
    _geoQuery = [geoFire queryAtLocation:center withRadius:0.1];

    [_geoQuery observeEventType:GFEventTypeKeyEntered withBlock:^(NSString *theirLinkedInUserId, CLLocation *theirLocation) {
        
        if (linkedInUserId != theirLinkedInUserId) {
            
            NSNumber *timeNow = @([[NSDate date] timeIntervalSince1970]);
            NSNumber *lat = @(theirLocation.coordinate.latitude);
            NSNumber *lng = @(theirLocation.coordinate.longitude);
            
            NSDictionary *match = @{@"lat" : lat, @"long" : lng, @"time" : timeNow};
            
            [self saveMatch:match withUser:linkedInUserId andUser:theirLinkedInUserId];
            [self saveMatch:match withUser:theirLinkedInUserId andUser:linkedInUserId];
        }
    }];
}

- (void)saveMatch: (NSDictionary*) match withUser:(NSString*) userA andUser:(NSString*) userB {
    Firebase *matchesFirebase = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/matches/%@/%@", userA, userB]];
    [matchesFirebase setValue:match];
}

- (void)setProfile:(LinkedInProfile *)profile {
    _profile = profile;
}

- (void)updateProfileDetailsInView {

    industryLabel.text = [_profile industry];
    firstNameLabel.text = [_profile firstName];
    jobLabel.text = [_profile companyName];
    uniNameLabel.text = [_profile lastSchoolName];
    uniCourseLabel.text = [_profile fieldOfStudy];
    
    profilePicImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[_profile pictureURL]]];
    profileBackgroundView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[_profile pictureURL]]];
}


@end
