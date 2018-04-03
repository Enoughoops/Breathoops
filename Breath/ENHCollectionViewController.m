//
//  ENHCollectionViewController.m
//  Breath
//
//  Created by LinMo on 2018/3/22.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "ENHCollectionViewController.h"
#import "PinsiteCell.h"

//
#import "AddCell.h"

#import "ENHPinsiteStore.h"
#import "ENHPinsite.h"

#import "BNRWebViewController.h"

#import "BNRTransitionPush.h"

@interface ENHCollectionViewController () <UINavigationControllerDelegate>

@end

@implementation ENHCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark Life Cycle

- (instancetype)init {
    
    //直接声明为UICollectionViewController，就需要在init方法中依据一个Layout(默人FlowLayout)初始化
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //水平方向项项之间的距离
    flowLayout.minimumInteritemSpacing = 30;
    //行间的距离
    flowLayout.minimumLineSpacing = 40;
    //每一节的内距离
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 10, 30, 10);
    //每一项的尺寸
    flowLayout.itemSize = CGSizeMake(90, 128);
    
    self = [super initWithCollectionViewLayout:flowLayout];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor =[UIColor whiteColor];
    
    //设置collectionView的代理和数据源
    self.collectionView.delegate =  self;
    self.collectionView.dataSource = self;
    
    
    //用Nib注册自定义的Cell
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PinsiteCell" bundle:nil] forCellWithReuseIdentifier:@"PinsiteCell"];
    
    //
    [self.collectionView registerNib:[UINib nibWithNibName:@"AddCell" bundle:nil] forCellWithReuseIdentifier:@"AddCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //隐藏NavigationBar
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.collectionView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
}

-  (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}


#pragma mark <UICollectionViewDataSource>

//数据源方法之一，返回有几小节
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//数据源方法之二，返回每小节有几项
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray * allPinites = [[ENHPinsiteStore sharedStore]allPinsites];
    return allPinites.count+1;
}

//数据源方法之三，定义每一项的具体内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * allPinsites = [[ENHPinsiteStore sharedStore]allPinsites];
    //
    if (indexPath.row == allPinsites.count)
    {
        AddCell *addCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddCell" forIndexPath:indexPath];
        return addCell;
    }
    
    //拿到在didLoad注册的自定义Cell
    PinsiteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PinsiteCell" forIndexPath:indexPath];
    
    //取自定义的四个样例PinSites
    //
    NSArray *pinsites = [[ENHPinsiteStore sharedStore]allPinsites];
    ENHPinsite *pinsite =pinsites[indexPath.row];
    cell.siteView.image = pinsite.icon;
    cell.siteLabel.text = pinsite.name;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

//代理方法之一，按下cell就打开WebView加载它代表的Page
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * allPinsites = [[ENHPinsiteStore sharedStore]allPinsites];
    //
    if (indexPath.row == allPinsites.count)
    {
        NSArray *readySites =   [ENHPinsiteStore sharedStore].readyPinsites;
        ENHPinsite *readySite = readySites[0];
        ENHPinsite *pinsite = [[ENHPinsiteStore sharedStore]createPinsite];
        pinsite.url = readySite.url;
        pinsite.icon = readySite.icon;
        pinsite.name = readySite.name;
        [self.collectionView reloadData];
        
    } else {
        BNRWebViewController *webViewController = [[BNRWebViewController alloc]init];
        ENHPinsite *selectedPinsite = [[ENHPinsiteStore sharedStore]allPinsites][indexPath.item];
        webViewController.URL = selectedPinsite.url;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

#pragma mark <UINavigationControllerDelegate>

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    if (fromVC == self && [toVC isKindOfClass:[BNRWebViewController class]]) {
        return [[BNRTransitionPush alloc]init];
    }
    else {
        return nil;
    }
}

@end
