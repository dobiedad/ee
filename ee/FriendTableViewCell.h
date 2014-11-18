#import <UIKit/UIKit.h>
#import "LinkedInProfile.h"


@interface FriendTableViewCell : UITableViewCell
-(void)setProfile: (LinkedInProfile*) profile;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UIView *chatButtonView;

@end
