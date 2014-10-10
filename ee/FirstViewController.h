//
//  FirstViewController.h
//  ee
//
//  Created by Leo Mdivani on 02/10/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *signinButton;

@property (weak, nonatomic) IBOutlet UIButton *getDataButton;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;

@end

