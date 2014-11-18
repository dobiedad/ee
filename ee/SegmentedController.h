//
//  SegmentedController.h
//  ee
//
//  Created by Leo Mdivani on 07/11/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchesSegment;
@property (weak, nonatomic) IBOutlet UIView *matchesContainer;
@property (weak, nonatomic) IBOutlet UIView *friendsContainer;

@end
