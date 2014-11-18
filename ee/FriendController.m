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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    LinkedInProfile *profile1 = [[LinkedInProfile alloc] initWithLinkedInApiUserData:@{
                                                                                       @"firstName": @"Jack"
                                                                                       
                                                                                       }];
    LinkedInProfile *profile2 = [[LinkedInProfile alloc] initWithLinkedInApiUserData:@{
                                                                                       @"firstName": @"Jill"
                                                                                       }];
    
    friends = [NSArray arrayWithObjects:profile1, profile2, nil];
    
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
    
    // segue to slack
    
    [self performSegueWithIdentifier:@"slack" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"slack"]) {
        SlackController *slackController = [segue destinationViewController];
        [slackController setOtherUsersProfile:_selectedProfile];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}


@end
