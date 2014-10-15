#import "MatchesController.h"
#import <Firebase/Firebase.h>
#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"

@interface MatchesController () <UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation MatchesController

NSMutableArray *_profiles;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userId = [self getSavedLinkedInUserId];
    
    Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/matches/%@", userId]];
    
    FQuery* matchesQuery = [ref queryLimitedToNumberOfChildren:10];
    
    _profiles = [[NSMutableArray alloc] init];
    
    [matchesQuery observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        Firebase *theirProfile = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://incandescent-inferno-9409.firebaseio.com/users/%@/linkedInProfile", snapshot.name]];
        
        unsigned long matchCount = (unsigned long)[snapshot childrenCount] - 1;
        
        [theirProfile observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *theirProfileSnapshot) {
            
            [_profiles addObject:theirProfileSnapshot.value];
            if (_profiles.count == matchCount) {
                [self.collectionView reloadData];
            }
        }];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _profiles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatchesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"profileView" forIndexPath:indexPath];
    LinkedInProfile *profileData = _profiles[(NSUInteger) indexPath.row];
    [cell loadProfile: profileData];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatchesCollectionViewCell *cell = (MatchesCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];

    NSLog(@"touched cell %@ at indexPath %@", cell, indexPath);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)getSavedLinkedInUserId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *linkedInUserId = [defaults objectForKey:@"linkedInUserId"];
    return linkedInUserId;
}

@end
