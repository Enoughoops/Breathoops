//
//  ENHPinsiteStore.m
//  Breath
//
//  Created by LinMo on 2018/3/22.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "ENHPinsiteStore.h"
#import "ENHPinsite.h"

@interface ENHPinsiteStore()
@property (nonatomic) NSMutableArray *privatePinsites;
@property (nonatomic) NSMutableArray *privateReadyPinsites;
@end

@implementation ENHPinsiteStore

+(instancetype)sharedStore {
    //将sharedStore声明为静态变量，该方法返回时，系统不会释放这个变量
    static ENHPinsiteStore *sharedStore = nil;
    
    if (!sharedStore) {
        //之后不管执行几次这个方法，静态变量始终指向最初的BNRItemStore对象
        sharedStore = [[self alloc]initPrivate];
    }
    
    return sharedStore;
}

//如果调用了store的init方法就抛出异常提示使用sharedStore方法
-(instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use+[ENHPinsiteStore SharedStore]" userInfo:nil];
    return nil;
}

//私有的真正的初始方法
-(instancetype)initPrivate{
    self =  [super init];
    if (self) {
        //首先从document下恢复已固化的privatePinsites
        NSString *path = [self itemArchivePath];
        _privatePinsites = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        //如果没有固化的privatePinsites 就创建一个新的
        if (!_privatePinsites) {
            _privatePinsites = [[NSMutableArray alloc]init];
        }
        //
        _privateReadyPinsites = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        //如果没有固化的readyPinsites 就创建一个新的
        if (!_privateReadyPinsites) {
            _privateReadyPinsites = [[NSMutableArray alloc]init];
        }
    }
    return self;
}


//覆盖allItems的读方法，返回的是NSMutable类型的privateItems
-(NSArray *)allPinsites {
    return self.privatePinsites;
}

//添加一个随机Item方法的实现
-(ENHPinsite *)createPinsite {
    //    BNRItem *item = [BNRItem randomItem];
    ENHPinsite *pinsite = [[ENHPinsite alloc]init];
    [self.privatePinsites addObject:pinsite];
    return pinsite;
}

//删除Item方法的实现
-(void)removePinsite:(ENHPinsite *)pinsite{
    [self.privatePinsites removeObjectIdenticalTo:pinsite];
}

//移动一个Item在Items中位置的方法的实现
-(void)movePinsiteAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    ENHPinsite *pinsite = self.privatePinsites[fromIndex];
    [self.privatePinsites removeObjectAtIndex:fromIndex];
    [self.privatePinsites insertObject:pinsite atIndex:toIndex];
}


//获取固化对象的文件路径，头文件没有声明，是因为不需要暴露给其他文件
- (NSString *)itemArchivePath {
    //获取应用沙盒下的Documents目录
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

//保存privateItems中所有的Item对象
- (BOOL) saveChanges {
    NSString *path = [self itemArchivePath];
    //固化成功返回YES NSKeyedArchiver是NSCoder的具体实现类
    return [NSKeyedArchiver archiveRootObject:self.privatePinsites toFile:path];
}

+ (NSArray *)examplePinsites {
    ENHPinsite *pinsite1 = [[ENHPinsite alloc]initWithName:@"Enough's cold" icon:[UIImage imageNamed:@"thing01.jpg"] url:[NSURL URLWithString:@"https://enoughoops.github.io"]];
    ENHPinsite *pinsite2 = [[ENHPinsite alloc]initWithName:@"Apple" icon:[UIImage imageNamed:@"thing02.jpg"] url:[NSURL URLWithString:@"https://www.apple.com"]];
    ENHPinsite *pinsite3 = [[ENHPinsite alloc]initWithName:@"Bing" icon:[UIImage imageNamed:@"thing03.jpg"] url:[NSURL URLWithString:@"https://www.bing.com"]];
    ENHPinsite *pinsite4 = [[ENHPinsite alloc]initWithName:@"Google" icon:[UIImage imageNamed:@"thing04.jpg"] url:[NSURL URLWithString:@"https://www.google.com"]];
    ENHPinsiteStore *store = [self sharedStore];
    [store.privatePinsites addObject:pinsite1];
    [store.privatePinsites addObject:pinsite2];
    [store.privatePinsites addObject:pinsite3];
    [store.privatePinsites addObject:pinsite4];
    return store.privatePinsites;

}

//
- (NSArray *)readyPinsites {
    return self.privateReadyPinsites;
}

//
- (ENHPinsite *)addReadyPinsiteWithURL:(NSURL *)url {
    ENHPinsite *pinsite = [[ENHPinsite alloc]initWithName:@"V2EX" icon:[UIImage imageNamed:@"thing04.jpg"] url:url];
    ENHPinsiteStore *store = [ENHPinsiteStore sharedStore];

    [store.privateReadyPinsites insertObject:pinsite atIndex:0];
    return pinsite;
}

@end
