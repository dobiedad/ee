#import "MatchesCollectionViewLayout.h"

@implementation MatchesCollectionViewLayout

- (void)prepareLayout {
    
    CGFloat marginWidth = 10.f;
    CGFloat cellWidthHeightRatio = 1.3f;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    CGFloat cellsPerRow = 1.0f;
    
    if (screenWidth >= 480)
        cellsPerRow = 2.0f;
    
    if (screenWidth >= 720)
        cellsPerRow = 3.0f;
    
    CGFloat marginMultiple = 1.f + (1 / cellsPerRow);
    
    CGFloat cellWidth = (screenWidth / cellsPerRow) - (marginMultiple * marginWidth);
    
    self.itemSize = CGSizeMake(cellWidth, cellWidth * cellWidthHeightRatio);
    self.minimumInteritemSpacing = marginWidth;
    self.sectionInset = UIEdgeInsetsMake(marginWidth + 60, marginWidth, marginWidth, marginWidth);
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

@end