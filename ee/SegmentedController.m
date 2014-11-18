//
//  SegmentedController.m
//  ee
//
//  Created by Leo Mdivani on 07/11/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import "SegmentedController.h"

@interface SegmentedController ()

@end

@implementation SegmentedController
@synthesize matchesContainer;
@synthesize friendsContainer;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)indexChanged:(UISegmentedControl *)sender {
  
    if(self.matchesSegment.selectedSegmentIndex == 0)            // Checking which segment is selected using the segment index value
        
    {
        matchesContainer.hidden=false;
        friendsContainer.hidden=true;
      

        
    }
    
    else
        
        if(self.matchesSegment.selectedSegmentIndex == 1)
            
        {
            
            matchesContainer.hidden=true;
            friendsContainer.hidden=false;
            [UIView transitionWithView:friendsContainer
                              duration:0.7
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:NULL
                            completion:NULL];

            
        }
}

@end
