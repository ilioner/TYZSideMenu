//
//  CenterViewController.m
//  SideMenu
//
//  Created by Tywin on 16/7/22.
//  Copyright © 2016年 zql. All rights reserved.
//

#import "CenterViewController.h"
#import "TYZSideMenu.h"
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
