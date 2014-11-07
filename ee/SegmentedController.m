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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)indexChanged:(UISegmentedControl *)sender {
  
    if(self.matchesSegment.selectedSegmentIndex == 0)            // Checking which segment is selected using the segment index value
        
    {
        matchesContainer.hidden=false;

        
    }
    
    else
        
        if(self.matchesSegment.selectedSegmentIndex == 1)
            
        {
            
            matchesContainer.hidden=true;
            
        }
}

@end
