//
//  ENHPinsiteStore.h
//  Breath
//
//  Created by LinMo on 2018/3/22.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ENHPinsite;

@interface ENHPinsiteStore : NSObject

@property (nonatomic,readonly) NSArray *allPinsites;

@property (nonatomic,readonly) NSArray *readyPinsites;

+(instancetype)sharedStore;

-(ENHPinsite *)createPinsite;

-(void)removePinsite:(ENHPinsite *)pinsite;

-(void)movePinsiteAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (BOOL) saveChanges;

+ (NSArray *)examplePinsites;

//
- (ENHPinsite *)addReadyPinsiteWithURL:(NSURL *)url;

@end
