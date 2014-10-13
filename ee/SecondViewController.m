#import "SecondViewController.h"
#import <Firebase/Firebase.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userId = [self getSavedLinkedInUserId];
    
    Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/matches/%@", userId]];
    
    FQuery* matchesQuery = [ref queryLimitedToNumberOfChildren:10];
    
    [matchesQuery observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        Firebase *theirProfile = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/users/%@/linkedInProfile", snapshot.name]];
        
        [theirProfile observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *theirProfileSnapshot) {
            NSLog(@"%@", theirProfileSnapshot.value);
        }];
        
        //NSLog(@"%@ %@", snapshot.name, snapshot.value);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getSavedLinkedInUserId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *linkedInUserId = [defaults objectForKey:@"linkedInUserId"];
    return linkedInUserId;
}

@end
