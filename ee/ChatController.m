//
//  ChatController.m
//  ee
//
//  Created by Leo Mdivani on 29/10/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import "ChatController.h"

@interface ChatController ()

@end

@implementation ChatController
NSArray *chatUsers;
@synthesize backgroundImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    chatUsers = [NSArray arrayWithObjects:@"John", @"James", @"Roman", @"Max", @"Josh", @"Adrian", @"Tim", @"Sophie", @"Jack", @"Russel", @"Boris", @"Rachel", @"Ross", @"Monica", @"Pheobe", @"Joey",@"Paul",@"Andrew", nil];
    [self layoutBlur];
    


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chatUsers count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [chatUsers objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"bean.jpg"];
    tableView.backgroundColor= [UIColor clearColor];
    cell.backgroundColor = [UIColor colorWithRed: 68.0/255.0 green: 125.0/255.0 blue: 190.0/255.0 alpha: 0.1];


    

    return cell;
}


- (void)layoutBlur {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.backgroundImage.bounds];
    blurView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.backgroundImage insertSubview:blurView atIndex:0];
    [blurView.contentView addSubview:vibrancyEffectView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
