//
//  BNRWebViewController.m
//  NerdFeed
//
//  Created by LinMo on 2018/1/4.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "BNRWebViewController.h"

#import "ENHCollectionViewController.h"
#import "BNRTransitionPop.h"

@interface BNRWebViewController() <UINavigationControllerDelegate,UIGestureRecognizerDelegate> ;
@end

@implementation BNRWebViewController

- (void)loadView {
    UIWebView *webView = [[UIWebView alloc]init];
    webView.scalesPageToFit = YES;
    self.view = webView;
    //获取共享的UserDefaults
//    self.URL = [NSURL URLWithString:@"https://enoughoops.github.io"];
}

- (void)setURL:(NSURL *)URL {
    _URL = URL;
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}

#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScreenEdgePanGestureRecognizer *popGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panPopGesture:)];
    [popGesture setEdges:UIRectEdgeRight];
    [self.view addGestureRecognizer:popGesture];
    popGesture.delegate = self;
    //意味不明
    [self prefersStatusBarHidden];
    
    UIScreenEdgePanGestureRecognizer *backGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(backGesture:)];
    [backGesture setEdges:UIRectEdgeLeft];
    [self.view addGestureRecognizer:backGesture];
    backGesture.delegate = self;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];

    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark <GestureRecognizerDelegate>Handeler

- (void) panPopGesture:(UIPanGestureRecognizer *)recognizer {
    
    // 计算用户手指划了多远
    CGFloat progress = -[recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    //    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 创建过渡对象，弹出viewController
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 更新 interactive transition 的进度
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // 完成或者取消过渡
        if (progress > 0.25) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

- (void) backGesture:(UIPanGestureRecognizer *)recognizer {
    if ([(UIWebView *)self.view canGoBack]) {
        [(UIWebView *)self.view goBack];
    }
    
}

#pragma mark <NavigationViewControllerDelegate>代理方法

//如果animatorController是自定义的动画方法就返回一个interactionController交互方法
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[BNRTransitionPop class]]) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}

//如果跳转回Pinsites界面 就返回自定义的animatorController动画方法
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (fromVC == self && [toVC isKindOfClass:[ENHCollectionViewController class]]) {
        return [[BNRTransitionPop alloc]init];
    }
    else {
        return nil;
    }
}




@end
