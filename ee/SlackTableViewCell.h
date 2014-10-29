//
//  SlackTableViewCell.h
//  ee
//
//  Created by Leo Mdivani on 29/10/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kAvatarSize 30.0
#define kMinimumHeight 40.0

@interface SlackTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) BOOL needsPlaceholder;
@property (nonatomic) BOOL usedForMessage;

- (void)setPlaceholder:(UIImage *)image scale:(CGFloat)scale;

@end
