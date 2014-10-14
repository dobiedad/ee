#import "SecondViewController.h"
#import <Firebase/Firebase.h>
#import "MatchesCollectionViewCell.h"

@interface SecondViewController () <UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *MatchesCollectionView;
@property (strong, nonatomic) UIImage *usersProfileImage;

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
            NSString *usersProfilePicURL = [theirProfileSnapshot.value objectForKey:@"pictureUrl"];
            self.profilePicImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:usersProfilePicURL]]];


        }];
        
        //NSLog(@"%@ %@", snapshot.name, snapshot.value);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatchesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.MatchesImageView.image = self.usersProfileImage;
    
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
