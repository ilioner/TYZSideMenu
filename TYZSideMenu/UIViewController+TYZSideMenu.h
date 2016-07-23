//
//  UIViewController+XTSideMenu.h
//  NewXTNews
//
//  Created by XT on 14-8-9.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYZSideMenu;

@interface UIViewController (TYZSideMenu)

@property (nonatomic, strong, readonly) TYZSideMenu *sideMenuViewController;

@end
