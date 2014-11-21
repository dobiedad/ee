
#import "FriendTableViewCell.h"
#import "LinkedInProfile.h"

@implementation FriendTableViewCell
@synthesize profilePic;
@synthesize firstNameLabel;
LinkedInProfile *_profile;

@synthesize chatButtonView;

- (void)layoutSubviews{
    [super layoutSubviews];
    [self profileImage];
   
    
}

- (void)profileImage {
    self.profilePic.layer.cornerRadius = 40.0;
    self.profilePic.layer.borderColor = [UIColor greenColor].CGColor;
    self.profilePic.layer.borderWidth = 1.5;
    self.profilePic.clipsToBounds = YES;
    self.profilePic.layer.masksToBounds = YES;
    self.profilePic.image = [UIImage imageNamed:@"mrbean.png"];
    self.chatButtonView.layer.cornerRadius = 31.0;

    self.chatButtonView.clipsToBounds = YES;
    self.chatButtonView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed: 68.0/255.0 green: 125.0/255.0 blue: 190.0/255.0 alpha: 0.1];
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (IBAction)chatButtonClicked:(id)sender {
    [[self tableView].delegate performSelector:@selector(clickedChat:) withObject:_profile];
}

- (UITableView *)tableView
{
    UIView *view;
    for (view = self.superview; ![view isKindOfClass:UITableView.class]; view = view.superview);
    return (UITableView *)view;
}

-(void)setProfile: (LinkedInProfile*) profile {
    _profile = profile;
    self.firstNameLabel.text = profile.firstName;
}

@end