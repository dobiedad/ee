//
//  FirstViewController.h
//  ee
//
//  Created by Leo Mdivani on 02/10/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GeoFire/GeoFire.h>



@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *signinButton;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *uniCourseLabel;

@end

