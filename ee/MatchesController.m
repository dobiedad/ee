#import "MatchesController.h"
#import <Firebase/Firebase.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MatchesCollectionViewCell.h"

@interface MatchesController () <UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *MatchesCollectionView;
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
                [self.MatchesCollectionView reloadData];
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
    NSDictionary *profileData = [_profiles objectAtIndex:indexPath.row];
    NSString *pictureUrl = [profileData objectForKey:@"pictureUrl"];
    // cell.MatchesImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pictureUrl]]];
    // cell.MatchesImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell.MatchesImageView sd_setImageWithURL:[NSURL URLWithString:pictureUrl] placeholderImage:nil];
    
    NSLog(@"added cell with image: %@", pictureUrl);
    
    return cell;
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
