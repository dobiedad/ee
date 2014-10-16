#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "UIImageView+WebCache.h"

@implementation MatchesCollectionViewCell
@synthesize imageView;

- (void)loadProfile:(LinkedInProfile *)profile {
    [self.imageView sd_setImageWithURL:[profile pictureURL] placeholderImage:nil];
}

@end
