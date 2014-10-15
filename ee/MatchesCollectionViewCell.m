#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "UIImageView+WebCache.h"

@implementation MatchesCollectionViewCell
@synthesize imageView;

- (void)loadProfile:(LinkedInProfile *)profile {
    NSString *pictureUrl = profile[@"pictureUrl"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:nil];
}
@end
