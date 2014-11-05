#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "UIImageView+WebCache.h"
#import "GPUImage.h"
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>


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
@synthesize constraintsView;
- (void)layoutForSize:(CGSize *)size {
    
}

- (void)filters:(LinkedInProfile *)profile {
    UIImage *inputImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[profile pictureURL]]];
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImagePixellateFilter *stillImageFilter = [[GPUImagePixellateFilter alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    self.imageView.image=currentFilteredVideoFrame;
}

- (void)loadProfile:(LinkedInProfile *)profile {
    _profile = profile;
    jobLabel.text =  [_profile companyName], [_profile industry];
    nameLabel.text = [_profile firstName];
    constraintsView.layer.cornerRadius=5;
    constraintsView.layer.masksToBounds = YES;
    
    
    
    [self filters:profile];
    
    

}




- (LinkedInProfile *)profile {
    return _profile;
}

- (IBAction)friendButtonClicked:(id)sender {
    
    
}
@end
