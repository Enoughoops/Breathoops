//
//  ENHPinsite.m
//  Breath
//
//  Created by LinMo on 2018/3/22.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "ENHPinsite.h"


@implementation ENHPinsite

- (instancetype)initWithName:(NSString*)name icon:(UIImage*)icon url:(NSURL*)url {
    self = [super init];
    if (self != nil) {
        _name = name;
        _icon = icon;
        _url = url;
    }
    return  self;
}

@end
