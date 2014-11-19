#import "FriendController.h"
#import "ProfileController.h"
#import "FriendTableViewCell.h"
#import "SlackController.h"
#import <QuartzCore/QuartzCore.h>

@interface FriendController ()

@end

@implementation FriendController

NSArray *friends;
LinkedInProfile *_selectedProfile;
@synthesize backgroundImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LinkedInProfile *profile1 = [[LinkedInProfile alloc] initWithLinkedInApiUserData:@{
                                                                                       @"firstName": @"Jack"
                                                                                       
                                                                                       }];
    LinkedInProfile *profile2 = [[LinkedInProfile alloc] initWithLinkedInApiUserData:@{
                                                                                       @"firstName": @"Jill"
                                                                                       }];
    
    friends = [NSArray arrayWithObjects:profile1, profile2, nil];
    [self layoutBlur];
 
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FriendCell";
    tableView.backgroundColor= [UIColor clearColor];

    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    }
    [cell setProfile: [friends objectAtIndex:indexPath.row]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // fetch the Profile from the underlying array
    [self performSegueWithIdentifier:@"showProfile" sender:self];
    

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"slack"]) {
        SlackController *slackController = [segue destinationViewController];
        [slackController setOtherUsersProfile:_selectedProfile];
    }
    if ([[segue identifier] isEqualToString:@"showProfile"]) {
        ProfileController *profileController = [segue destinationViewController];
        [profileController setProfile:_selectedProfile];
    }
    
}
-(void)clickedChat:(LinkedInProfile *)profile{
    _selectedProfile=profile;
    [self performSegueWithIdentifier:@"slack" sender:self];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (void)layoutBlur {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.backgroundImage.bounds];
    blurView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.backgroundImage insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
}




@end
