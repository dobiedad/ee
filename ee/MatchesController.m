#import "MatchesController.h"
#import <Firebase/Firebase.h>
#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "FirebaseClient.h"

@interface MatchesController () <UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation MatchesController
@synthesize matchesBackground;

NSArray *_profiles;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.matchesBackground.image = [UIImage imageNamed:@"colour.jpg"];
    
    

    
    NSString *userId = [self getSavedLinkedInUserId];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    
    CGFloat marginWidth = 10.f;
    

    CGFloat itemWidth = (screenWidth / 2.0f) - (1.5f * marginWidth);
    
    [self layout].itemSize = CGSizeMake(itemWidth, itemWidth * 1.3f);
    [self layout].minimumInteritemSpacing = marginWidth;
    [self layout].sectionInset = UIEdgeInsetsMake(marginWidth, marginWidth, marginWidth, marginWidth);
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    

    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.matchesBackground.bounds];
    blurView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.matchesBackground insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
    

    

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
