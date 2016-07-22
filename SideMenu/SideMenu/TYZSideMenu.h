//
//  TYZSideMenu.h
//  SideMenu
//
//  Created by Tywin on 16/7/22.
//  Copyright © 2016年 zql. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYZSideMenu : UIViewController

@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) UIViewController *leftSideViewController;
@property (nonatomic, strong) UIViewController *rightSideViewController;
@property (nonatomic, assign) CGFloat leftVisibleOffset;
@property (nonatomic, assign) CGFloat rightVisibleOffset;
@property (nonatomic, assign) BOOL isRightShow;
@property (nonatomic, assign) BOOL isLeftShow;

- (TYZSideMenu *)initWithContentViewController:(UIViewController *)contentViewController leftSideViewController:(UIViewController *)leftSideViewController rightSideViewController:(UIViewController *)rightSideViewController;

- (void)showLeftSideMenu;
- (void)showRightSideMenu;
- (void)hiddenAll;

@end
