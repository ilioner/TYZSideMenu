//
//  UIViewController+TYZSideMenu.m
//  SideMenu
//
//  Created by Tywin on 16/7/22.
//  Copyright © 2016年 zql. All rights reserved.
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
