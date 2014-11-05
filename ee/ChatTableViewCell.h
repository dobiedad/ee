#import <UIKit/UIKit.h>
#import "LinkedInProfile.h"

@interface ChatTableViewCell : UITableViewCell

-(void)setProfile: (LinkedInProfile*) profile;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicImage;
@property (weak, nonatomic) IBOutlet UITextView *lastMessage;

@end
