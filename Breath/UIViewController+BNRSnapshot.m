//
//  UIViewController+BNRSnapshot.m
//  NerdFeed
//
//  Created by LinMo on 2018/3/17.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "UIViewController+BNRSnapshot.h"
#import <objc/runtime.h>

@implementation UIViewController(BNRSnapshot)

- (UIView *)snapshot {
    
    UIView *view = objc_getAssociatedObject(self, @selector(snapshot));
    if (!view) {
        view = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        [self setSnapshot:view];
    }
    
    return view;
}

- (void)setSnapshot: (UIView *)snapshot {
    
    objc_setAssociatedObject(self, @selector(snapshot), snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
