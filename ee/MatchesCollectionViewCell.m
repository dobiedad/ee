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
    [self.imageView sd_setImageWithURL:[profile pictureURL] placeholderImage:nil];
    jobLabel.text =  [_profile companyName], [_profile industry];
    nameLabel.text = [_profile firstName];
}

- (LinkedInProfile *)profile {
    return _profile;
}

- (IBAction)friendButtonClicked:(id)sender {
    
    
}
@end
