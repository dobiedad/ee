#import "ProfileController.h"
#import <UIView+MTAnimation.h>
#import <AudioToolbox/AudioServices.h>
#import "LinkedInClient.h"



@interface ProfileController ()
@end


@implementation ProfileController {
    LinkedInProfile *_profile;
}
@synthesize profilePicImageView;
@synthesize linksTextView;
@synthesize jobLabel;
@synthesize firstNameLabel;
@synthesize profileBackgroundView;
@synthesize aboutMeTextView;
@synthesize friendButtonView;
@synthesize chatButtonView;

@synthesize profileScrollView;





- (void)viewDidLoad {
    [super viewDidLoad];
    [self paralax];
    [self blur];
    [self profilePic];
    [self buttonBorderRadius];
    [self updateProfileDetailsInView];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [aboutMeTextView endEditing:YES];
}
- (void)layoutScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    profileScrollView.contentSize = CGSizeMake(screenWidth,screenHeight * 1.2);
    profileScrollView.showsHorizontalScrollIndicator = NO;
    profileScrollView.showsVerticalScrollIndicator=YES;
    profileScrollView.pagingEnabled = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)blur {
    //[self startLocationManager];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    aboutMeTextView.layer.cornerRadius=5;
    

    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.profileBackgroundView.bounds];
    blurView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.profileBackgroundView insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
}



- (void)profilePic {
    self.profilePicImageView.layer.cornerRadius = 100.0;
    [profilePicImageView setClipsToBounds:YES];
    
    
    NSInteger imageWidth = profilePicImageView.frame.size.width;
    profilePicImageView.layer.cornerRadius=imageWidth/2;
    profilePicImageView.layer.masksToBounds = YES;
    
    
    self.profilePicImageView.layer.borderColor = [UIColor greenColor].CGColor;
    self.profilePicImageView.layer.borderWidth = 1.5;
    UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedProfileImage)];
    
    [profilePicImageView setUserInteractionEnabled:YES];
    
    [profilePicImageView addGestureRecognizer:newTap];
}


- (void) tappedProfileImage {
    CGFloat originX = profilePicImageView.frame.origin.x;
    
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [profilePicImageView setTransform:CGAffineTransformRotate(profilePicImageView.transform, M_PI  )];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [profilePicImageView setTransform:CGAffineTransformRotate(profilePicImageView.transform, M_PI  )];
        } completion:^(BOOL finished) {}];
    }];
    
   
}
- (void)buttonBorderRadius{
    CGFloat buttonWidth = chatButtonView.frame.size.width;
    friendButtonView.layer.cornerRadius=buttonWidth/2;
    chatButtonView.layer.cornerRadius=buttonWidth/2;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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




- (void)setProfile:(LinkedInProfile *)profile {
    _profile = profile;
    [self updateProfileDetailsInView];
}

- (void)updateProfileDetailsInView {

//    industryLabel.text = [_profile industry];
    firstNameLabel.text = [_profile firstName];
    jobLabel.text = [NSString stringWithFormat:@"@%@", [_profile companyName]];
//    uniNameLabel.text = [_profile lastSchoolName];
//    uniCourseLabel.text = [_profile fieldOfStudy];

    
    linksTextView.text = [NSString stringWithFormat:@"%tu Links", [_profile connections]];
    
    profilePicImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[_profile pictureURL]]];
    profileBackgroundView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[_profile pictureURL]]];
    
    LinkedInClient *client = [[LinkedInClient alloc] init];
//    
//    NSString *companyId = [NSString stringWithFormat:@"%tu", [_profile companyId]];
//    [client getLogoUrlForCompanyId:companyId andCallBlockWithURL:^(NSURL *logoUrl) {
//        companyImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:logoUrl]];
//    }];
}

@end
