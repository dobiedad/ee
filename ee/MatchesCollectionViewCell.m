#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "UIImageView+WebCache.h"
#import "GPUImage.h"
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <GeoFire/GeoFire.h>
#import "LinkedInClient.h"
#import "LinkedInProfile.h"



@implementation MatchesCollectionViewCell {
    LinkedInProfile *_profile;
}
@synthesize imageView;
@synthesize jobLabel;
@synthesize nameLabel;
@synthesize cancelView;
@synthesize friendView;
@synthesize buttonsPanel;
@synthesize imagePanel;
@synthesize coverPhoto;
@synthesize constraintsView;
@synthesize connectionsLabel;
- (void)layoutForSize:(CGSize *)size {
    
}

- (void)filters:(LinkedInProfile *)profile {
    
    NSInteger imageWidth = imageView.frame.size.width;
    NSInteger buttonWidth = cancelView.frame.size.width;

    imageView.layer.cornerRadius=imageWidth/2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor = [UIColor greenColor].CGColor;
    imageView.layer.borderWidth = 1;
    
    cancelView.layer.cornerRadius=buttonWidth/2;
    cancelView.layer.masksToBounds = YES;

    
    friendView.layer.cornerRadius=buttonWidth/2;
    friendView.layer.masksToBounds = YES;
//    [self blur];


    
//    UIImage *inputImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[profile pictureURL]]];
//    //self.imageView.image=[self applyFilterTo:inputImage];
//    self.imageView.image=inputImage;
    
//    [self.imageView sd_setImageWithURL:[profile pictureURL]
//                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
//    UIImage *inputImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[profile pictureURL]]];

//    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
//    GPUImagePolkaDotFilter *stillImageFilter = [[GPUImagePolkaDotFilter alloc] init];
//    
//    [stillImageSource addTarget:stillImageFilter];
//    [stillImageFilter useNextFrameForImageCapture];
//    [stillImageSource processImage];
//    
//    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
//
//    self.imageView.image=currentFilteredVideoFrame;


}


- (void)blur {
    //[self startLocationManager];
    
    CGFloat coverWidth = coverPhoto.frame.size.width;
    CGFloat coverHeight = coverPhoto.frame.size.height;


    
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.coverPhoto.bounds];
    blurView.frame = CGRectMake(0, 0, coverWidth, coverHeight);
    [self.coverPhoto insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
}



//- (UIImage *)applyFilterTo:(UIImage *)image {
//    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
//    GPUImagePolkaDotFilter *stillImageFilter = [[GPUImagePolkaDotFilter alloc] init];
//    
//    [stillImageSource addTarget:stillImageFilter];
//    [stillImageFilter useNextFrameForImageCapture];
//    [stillImageSource processImage];
//    
//    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
//    return currentFilteredVideoFrame;
//}

- (void)loadProfile:(LinkedInProfile *)profile {
    _profile = profile;
    jobLabel.text =  [_profile companyName], [_profile industry];
    nameLabel.text = [_profile firstName];
    connectionsLabel.text = [NSString stringWithFormat:@"%tu", [_profile connections]];
    constraintsView.layer.cornerRadius=1;
    constraintsView.layer.masksToBounds = YES;

    [self filters:profile];

    

}
- (void)saveFriend: (NSDictionary*) friend withUser:(NSString*) userA andUser:(NSString*) userB {
    Firebase *friendsFirebase = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/friends/%@/%@", userA, userB]];
    [friendsFirebase setValue:friend];
}

- (IBAction)cancelTapped:(id)sender {
    NSLog(@"CANCEL TAPPED");
}


- (LinkedInProfile *)profile {
    
    return _profile;
}

- (IBAction)friendButtonClicked:(id)sender {
    
    NSNumber *timeNow = @([[NSDate date] timeIntervalSince1970]);
    NSString *friend = @"yes";
    NSDictionary *match = @{ @"friend" : friend, @"time" : timeNow};
    [self saveFriend:friend withUser:@"a" andUser:@"b"];

    
}
@end
