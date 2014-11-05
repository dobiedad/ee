#import "ChatTableViewCell.h"
#import "LinkedInProfile.h"

@implementation ChatTableViewCell

@synthesize firstNameLabel;
@synthesize profilePicImage;
@synthesize lastMessage;


- (void)layoutSubviews{
    [super layoutSubviews];
    [self profilePic];
    lastMessage.layer.cornerRadius = 5;
    lastMessage.userInteractionEnabled=false;

    
}

- (void)profilePic {
    self.profilePicImage.layer.cornerRadius = 40.0;
    self.profilePicImage.layer.borderColor = [UIColor greenColor].CGColor;
    self.profilePicImage.layer.borderWidth = 1.5;
    self.profilePicImage.clipsToBounds = YES;
    self.profilePicImage.layer.masksToBounds = YES;
    self.profilePicImage.image = [UIImage imageNamed:@"mrbean.png"];
    
    self.backgroundColor = [UIColor colorWithRed: 68.0/255.0 green: 125.0/255.0 blue: 190.0/255.0 alpha: 0.1];
}


-(void)setProfile: (LinkedInProfile*) profile {
    self.firstNameLabel.text = profile.firstName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
