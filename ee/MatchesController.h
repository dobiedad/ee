#import <UIKit/UIKit.h>
#import "FXBlurView.h"


@interface MatchesController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) IBOutlet FXBlurView *blurView;
@property (strong, nonatomic) IBOutlet UIImageView *matchesBackground;

@end
