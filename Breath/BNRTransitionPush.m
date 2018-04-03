//
//  BNRTransitionPush.m
//  NerdFeed
//
//  Created by LinMo on 2018/3/16.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "BNRTransitionPush.h"
#import "ENHCollectionViewController.h"
#import "BNRWebViewController.h"
#import "UIViewController+BNRSnapshot.h"


@implementation BNRTransitionPush

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    BNRCoursesTableViewController *fromViewController = (BNRCoursesTableViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    BNRWebViewController *toViewController = (BNRWebViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    UIView *containerView = [transitionContext containerView];
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//
//    [UIView animateWithDuration:duration animations:^{
//        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width,0);
//    }completion:^(BOOL finished) {
//        /**
//         *  当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
//         */
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
    
//    UIViewController * fromVc   = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//
//    UIViewController * toVc     = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    NSTimeInterval duration     = [self transitionDuration:transitionContext];
//
//    CGRect bounds               = [[UIScreen mainScreen] bounds];
//
//    fromVc.view.hidden          = YES;
//
//    [[transitionContext containerView] addSubview:toVc.view];
//
//    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
//
//    fromVc.navigationController.navigationBar.hidden = YES;
//
//    toVc.navigationController.navigationBar.hidden = YES;
//
//    toVc.navigationController.view.transform =
//    CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0);
//
//    [UIView animateWithDuration:duration
//                          delay:0
//         usingSpringWithDamping:1.0
//          initialSpringVelocity:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         fromVc.snapshot.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(bounds) * 0.3, 0);
//                         toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0, 0);
//                     }
//                     completion:^(BOOL finished) {
//                         fromVc.view.hidden = NO;
//                         [fromVc.snapshot removeFromSuperview];
//                         [transitionContext completeTransition:YES];
//                     }];
    
    
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    fromVc.view.hidden = YES;
    [[transitionContext containerView] addSubview:fromVc.snapshot];
    [[transitionContext containerView] addSubview:toVc.view];
    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
    toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
        fromVc.navigationController.navigationBar.hidden = YES;
    
        toVc.navigationController.navigationBar.hidden = YES;
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.snapshot.alpha = 0.3;
                         fromVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);
                         toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
                     }
                     completion:^(BOOL finished) {
                         fromVc.view.hidden = NO;
                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

@end
