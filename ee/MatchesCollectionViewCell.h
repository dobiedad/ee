#import <UIKit/UIKit.h>

@class LinkedInProfile;

@interface MatchesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonsPanel;
@property (weak, nonatomic) IBOutlet UIView *imagePanel;
@property (weak, nonatomic) IBOutlet UIView *friendView;
@property (weak, nonatomic) IBOutlet UIView *cancelView;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIView *constraintsView;
@property (weak, nonatomic) IBOutlet UIImageView *coverPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *coverPhotoBottom;


- (void)loadProfile:(LinkedInProfile *)profile;

- (LinkedInProfile *)profile;
@end
