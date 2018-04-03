//
//  BNRWebViewController.h
//  NerdFeed
//
//  Created by LinMo on 2018/1/4.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRWebViewController : UIViewController;
- (void)openURL:(NSURL *)URL;
@property (nonatomic) NSURL *URL;
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@end
