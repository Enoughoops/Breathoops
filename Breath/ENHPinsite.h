//
//  ENHPinsite.h
//  Breath
//
//  Created by LinMo on 2018/3/22.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ENHPinsite : NSObject
@property (strong,nonatomic) UIImage *icon;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSURL *url;

- (instancetype)initWithName:(NSString*)name icon:(UIImage*)icon url:(NSURL*)url;

@end
