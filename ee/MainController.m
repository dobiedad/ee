#import "MainController.h"
#import "LinkedInProfile.h"
#import "TLYShyNavBarManager.h"
#import <UIView+MTAnimation.h>
#import <GeoFire/GeoFire.h>

@import CoreLocation;

@interface MainController () <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation MainController {
    LinkedInProfile *_profile;
    GFCircleQuery *_geoQuery;
}


@synthesize scrollView;
@synthesize matchesContainer;
@synthesize profileContainer;
@synthesize chatContainer;
@synthesize backgroundImage;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self blur];
    [self layoutScrollView];

   
    NSLog(@"%lu", self.childViewControllers.count);
    
    for (UIViewController *viewController in self.childViewControllers)
    {
        if ([viewController respondsToSelector:@selector(setProfile:)]) {
            [viewController performSelector:@selector(setProfile:) withObject:_profile];
        }
    }
    
    [self startLocationManager];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self layoutScrollView];
}

- (void)layoutScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    scrollView.contentSize = CGSizeMake(screenWidth * 3,scrollView.contentSize.height);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
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

- (void)blur {
    //[self startLocationManager];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.backgroundImage.bounds];
    blurView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.backgroundImage insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
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
            
            // TODO: Get the existing match. If it exists, update it, otherwise create it
            
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

@end
