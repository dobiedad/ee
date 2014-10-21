#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "UIImageView+WebCache.h"

@implementation MatchesCollectionViewCell {
    LinkedInProfile *_profile;
}
@synthesize imageView;
@synthesize jobLabel;
@synthesize nameLabel;



- (void)loadProfile:(LinkedInProfile *)profile {
    _profile = profile;
    [self.imageView sd_setImageWithURL:[profile pictureURL] placeholderImage:nil];
    self.imageView.layer.cornerRadius = 60;
    [imageView setClipsToBounds:YES];
    jobLabel.text =  [_profile companyName], [_profile industry];
    nameLabel.text = [_profile firstName];
 
}

- (LinkedInProfile *)profile {
    return _profile;
}
@end
