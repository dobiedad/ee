#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "UIImageView+WebCache.h"

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

- (void)layoutForSize:(CGSize *)size {
    
}

- (void)loadProfile:(LinkedInProfile *)profile {
    _profile = profile;
    
    // NSDictionary *views = NSDictionaryOfVariableBindings(imagePanel, buttonsPanel);
    
//    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

    
    // self.translatesAutoresizingMaskIntoConstraints = NO;
//    imagePanel.translatesAutoresizingMaskIntoConstraints = NO;
//    buttonsPanel.translatesAutoresizingMaskIntoConstraints = NO;
 
    
    
    
    
    [self.imageView sd_setImageWithURL:[profile pictureURL] placeholderImage:nil];
    jobLabel.text =  [_profile companyName], [_profile industry];
    nameLabel.text = [_profile firstName];


//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    
//    
//    
//    
//    CGFloat marginWidth = 10.f;
//    
//
//    
//    CGFloat itemWidth = (screenWidth / 2.0f) - (1.5f * marginWidth);
//    CGFloat height = (((itemWidth * 1.3f)/3)*2);
////    NSString *heightString = [NSString stringWithFormat:@"%f", height];
//
//    
////    NSLog(heightString);
//    
//    CGRect imageFrame = self.imagePanel.frame;
//    
//    imageFrame.size.width = (screenWidth / 2.0f);
//    imageFrame.size.height = height;
//    [self.imagePanel setFrame:imageFrame];
    
    
}




//-(void)updateConstraints{
//    // add your constraints
//    
//    [super updateConstraints];
//    
//    NSLayoutConstraint *imageHeight = [NSLayoutConstraint constraintWithItem:imagePanel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0];
//    [self addConstraint:imageHeight];
//    
//    NSLayoutConstraint *imagePosition = [NSLayoutConstraint constraintWithItem:imagePanel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
//    [self addConstraint:imagePosition];
//    
//    NSLayoutConstraint *buttonsHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:buttonsPanel attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0];
//    
//    [self addConstraint:buttonsHeight];
//    
//}
- (LinkedInProfile *)profile {
    return _profile;
}
@end
