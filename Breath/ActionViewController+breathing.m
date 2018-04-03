//
//  ActionViewController+breathing.m
//  Breath
//
//  Created by LinMo on 2018/1/19.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "ActionViewController+breathing.h"

@implementation ActionViewController (breathing)
- (void)breathing:(nonnull NSURL *)url {
    
    SEL selector = NSSelectorFromString(@"openURL:options:completionHandler:");
    
    UIResponder* responder = self;
    while ((responder = [responder nextResponder]) != nil) {
        NSLog(@"responder = %@", responder);
        if([responder respondsToSelector:selector] == true) {
            NSMethodSignature *methodSignature = [responder methodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            
            // Arguments
            NSDictionary<NSString *, id> *options = [NSDictionary dictionary];
            void (^completion)(BOOL success) = ^void(BOOL success) {
                NSLog(@"Completions block: %i", success);
            };
            
            [invocation setTarget: responder];
            [invocation setSelector: selector];
            [invocation setArgument: &url atIndex: 2];
            [invocation setArgument: &options atIndex:3];
            [invocation setArgument: &completion atIndex: 4];
            [invocation invoke];
            break;
        }
    }
}
@end
