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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateProfileDetails];

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

    [_geoQuery observeEventType:GFEventTypeKeyEntered withBlock:^(NSString *theirLinkedInUserId, CLLocation *location) {
        
        if (linkedInUserId != theirLinkedInUserId) {
            
            NSNumber *timeNow = [NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]];
            NSNumber *lat = [NSNumber numberWithDouble:location.coordinate.latitude];
            NSNumber *lng = [NSNumber numberWithDouble:location.coordinate.longitude];
            
            NSDictionary *match = [NSDictionary dictionaryWithObjects: @[lat, lng, timeNow ] forKeys: @[@"lat", @"long", @"time"]];
            
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
- (void)updateProfileDetails {
    
    NSString *profilePicURL = [_profile objectForKey:@"pictureUrl"];
    NSString *companyName = _profile[@"positions"][@"values"][0][@"company"][@"name"];
    NSString *lastSchoolName = _profile[@"educations"][@"values"][0][@"schoolName"];
    NSString *lastSchoolCourse = _profile[@"educations"][@"values"][0][@"fieldOfStudy"];
    
    NSString *industry = [_profile objectForKey:@"industry"];
    NSString *firstName = [_profile objectForKey:@"firstName"];
    
    industryLabel.text=industry;
    firstNameLabel.text=firstName;
    jobLabel.text=companyName;
    uniNameLabel.text= lastSchoolName;
    uniCourseLabel.text= lastSchoolCourse;
    
    profilePicImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
    
}


@end
