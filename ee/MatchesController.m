#import "MatchesController.h"
#import <Firebase/Firebase.h>
#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "FirebaseClient.h"

@interface MatchesController () <UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation MatchesController

NSArray *_profiles;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userId = [self getSavedLinkedInUserId];

    FirebaseClient *firebaseClient = [[FirebaseClient alloc] init];
    [firebaseClient matchesForUser: userId withBlock:^(NSArray *matches) {
        _profiles = matches;
        [self.collectionView reloadData];
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
    LinkedInProfile *profileData = (LinkedInProfile *)_profiles[(NSUInteger) indexPath.row];
    [cell loadProfile: profileData];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatchesCollectionViewCell *cell = (MatchesCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    LinkedInProfile *profile = [cell profile];
    NSLog(@"touched cell %@ at indexPath %@", [profile firstName], indexPath);
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
