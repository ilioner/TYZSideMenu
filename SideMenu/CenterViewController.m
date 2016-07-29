//
//  CenterViewController.m
//  SideMenu
//
//  Created by Tywin on 16/7/22.
//  Copyright © 2016年 zql. All rights reserved.
//

#import "CenterViewController.h"
@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLeft:(UIButton *)sender {
    if (self.sideMenuViewController) {
        [self.sideMenuViewController showLeftSideMenu];
    }
}

- (IBAction)showRight:(UIButton *)sender {
    if (self.sideMenuViewController) {
        [self.sideMenuViewController showRightSideMenu];
    }
}
- (IBAction)setNew:(UIButton *)sender {
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    CenterViewController *viewController = [[CenterViewController   alloc] init];
    viewController.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    self.sideMenuViewController.centerViewController = viewController;
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
