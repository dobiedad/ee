#import "MatchesController.h"
#import <Firebase/Firebase.h>
#import "MatchesCollectionViewCell.h"
#import "LinkedInProfile.h"
#import "FirebaseClient.h"
#import "ProfileController.h"

@interface MatchesController () <UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation MatchesController
@synthesize matchesBackground;

NSArray *_profiles;
LinkedInProfile *_selectedProfile;

- (void)loadMatchesFromFirebase {
    NSString *userId = [self getSavedLinkedInUserId];
    FirebaseClient *firebaseClient = [[FirebaseClient alloc] init];
    [firebaseClient matchesForUser: userId withBlock:^(NSArray *matches) {
        _profiles = matches;
        [self.collectionView reloadData];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.matchesBackground.image = [UIImage imageNamed:@"colour.jpg"];
    
    [self layoutBlur];
    [self layoutCollectionView];
    [self loadMatchesFromFirebase];
}

- (void) layoutCollectionView {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGFloat marginWidth = 10.f;

    CGFloat itemWidth = (screenWidth / 2.0f) - (1.5f * marginWidth);
    
    CGFloat topBarOffset = 75.f;
    
    [self layout].itemSize = CGSizeMake(itemWidth, itemWidth * 1.3f);
    [self layout].minimumInteritemSpacing = marginWidth;
    [self layout].sectionInset = UIEdgeInsetsMake(topBarOffset + marginWidth, marginWidth, marginWidth, marginWidth);
}


- (void)layoutBlur {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.matchesBackground.bounds];
    blurView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.matchesBackground insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
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
    _selectedProfile = [cell profile];
    [self performSegueWithIdentifier:@"selectedProfile" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectedProfile"]) {
        ProfileController *profileController = [segue destinationViewController];
        [profileController setProfile:_selectedProfile];
    }
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
