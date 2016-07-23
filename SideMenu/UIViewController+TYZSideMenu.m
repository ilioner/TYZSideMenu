//
//  UIViewController+XTSideMenu.m
//  NewXTNews
//
//  Created by XT on 14-8-9.
//  Copyright (c) 2014年 XT. All rights reserved.
//

#import "UIViewController+TYZSideMenu.h"
#import "TYZSideMenu.h"

@implementation UIViewController (TYZSideMenu)

- (TYZSideMenu *)sideMenuViewController
{
    UIViewController *superVC = self.parentViewController;
    while (superVC) {
        if ([superVC isKindOfClass:[TYZSideMenu class]]) {
            return (TYZSideMenu *)superVC;
        } else if (superVC.parentViewController && superVC.parentViewController != superVC) {
            superVC = superVC.parentViewController;
        } else {
            superVC = nil;
        }
    }
    return nil;
}

@end
