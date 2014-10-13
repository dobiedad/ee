#import "SecondViewController.h"
#import <Firebase/Firebase.h>

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize profilePicImageView;

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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coloredCell" forIndexPath:indexPath];
    profilePicImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
    
    return cell;
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
