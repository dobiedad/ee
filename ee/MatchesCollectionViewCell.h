#import <UIKit/UIKit.h>

@class LinkedInProfile;

@interface MatchesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)loadProfile:(LinkedInProfile *)profile;
@end
