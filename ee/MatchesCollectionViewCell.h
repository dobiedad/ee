#import <UIKit/UIKit.h>

@class LinkedInProfile;

@interface MatchesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)loadProfile:(LinkedInProfile *)profile;

- (LinkedInProfile *)profile;
@end
