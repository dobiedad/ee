//
//  NavigationController.h
//  ee
//
//  Created by Leo Mdivani on 28/10/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkedInProfile.h"

@interface NavigationController : UINavigationController
-(void)setProfile: (LinkedInProfile*) profile;

@end
