//
//  BNRTransitionPop.m
//  NerdFeed
//
//  Created by LinMo on 2018/3/15.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "BNRTransitionPop.h"
#import "ENHCollectionViewController.h"
#import "BNRWebViewController.h"
#import "UIViewController+BNRSnapshot.h"

@implementation BNRTransitionPop

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    BNRWebViewController *fromViewController = (BNRWebViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    BNRCoursesTableViewController *toViewController = (BNRCoursesTableViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toViewController.view];
//    toViewController.view.alpha = 0.0;
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//
////    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
////    [[transitionContext containerView] addSubview:toViewController.view];
//    [UIView animateWithDuration:duration animations:^{
//        fromViewController.view.transform = CGAffineTransformMakeTranslation(-[UIScreen mainScreen].bounds.size.width,0);
//        toViewController.view.alpha = 1.0;
//    }completion:^(BOOL finished) {
//        /**
//         *  当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
//         */
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
    
//
//    //自定义动画
//    UIViewController * fromVc   = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController * toVc     = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    NSTimeInterval duration     = [self transitionDuration:transitionContext];
//    CGRect bounds               = [[UIScreen mainScreen] bounds];
//    UIView * containerView = [transitionContext containerView];
//
////    [fromVc.view addSubview:fromVc.snapshot];
//
//    fromVc.navigationController.navigationBar.hidden = YES;
//
//    toVc.view.hidden = YES;
//    toVc.snapshot.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
//    toVc.snapshot.alpha = 1.0;
////    toVc.snapshot.transform = CGAffineTransformMakeScale(0.888, 0.888);
//
//    [containerView addSubview:fromVc.view];
//    [containerView addSubview:toVc.view];
//    [containerView addSubview:toVc.snapshot];
//    [containerView sendSubviewToBack:fromVc.view];
//
//
//
//    fromVc.navigationController.navigationBar.hidden = YES;
//
//    toVc.navigationController.navigationBar.hidden = YES;
//
//
//
//    [UIView animateWithDuration:duration
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
////                         fromVc.view.transform = CGAffineTransformMakeTranslation(- CGRectGetWidth(bounds), 0.0);
////                         toVc.snapshot.transform = CGAffineTransformIdentity;
//
//                         fromVc.view.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(bounds) * 0.3, 0.0);
////                         toVc.snapshot.alpha = 1.0;
//                         fromVc.view.alpha = 0.3;
//                         toVc.snapshot.transform = CGAffineTransformIdentity;
//
//                     }
//                     completion:^(BOOL finished) {
//                        fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
//
//                        toVc.view.hidden = NO;
//                        fromVc.view.hidden = NO;
//                        toVc.navigationController.navigationBar.hidden = NO;
//
//                         [toVc.snapshot removeFromSuperview];
//                         fromVc.snapshot = nil;
//
//                         // Reset toViewController's `snapshot` to nil
//                         if (![transitionContext transitionWasCancelled]) {
//                             toVc.snapshot = nil;
//                         }
//
////                         toVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
////                      if ([transitionContext transitionWasCancelled]) {
//                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//
////                         fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
////
////
////                         toVc.navigationController.navigationBar.hidden = NO;
////                         toVc.view.hidden = NO;
////
////                         [fromVc.snapshot removeFromSuperview];
////                         [toVc.snapshot removeFromSuperview];
////                         fromVc.snapshot = nil;
////
////                         // Reset toViewController's `snapshot` to nil
////                         if (![transitionContext transitionWasCancelled]) {
////                             toVc.snapshot = nil;
////                         }
////
////                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//                     }];
    
    
    

    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = [[UIScreen mainScreen] bounds];

//    [fromVc.view addSubview:fromVc.snapshot];
    fromVc.navigationController.navigationBar.hidden = YES;
    //    fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);

    //用快照表现ToVC的动画
    toVc.view.hidden = YES;
    toVc.snapshot.alpha = 0.3;
    toVc.snapshot.transform = CGAffineTransformMakeScale(0.888, 0.888);

    [[transitionContext containerView]addSubview:fromVc.view];
    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];

    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //fromVC向右移动整个屏幕
                         fromVc.view.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(bounds), 0.0);
                         toVc.snapshot.alpha = 1.0;
                         toVc.snapshot.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         //完成后让fromVC回到原来的位置
                         fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);


                         toVc.navigationController.navigationBar.hidden = NO;
                         toVc.view.hidden = NO;

                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         fromVc.snapshot = nil;

                         // Reset toViewController's `snapshot` to nil
                         if (![transitionContext transitionWasCancelled]) {
                             toVc.snapshot = nil;
                         }

                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


@end
