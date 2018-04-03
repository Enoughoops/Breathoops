//
//  ActionViewController.m
//  Open In Smile
//
//  Created by LinMo on 2018/1/18.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ActionViewController+breathing.h"


@interface ActionViewController ()

@property(strong,nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the item[s] we're handling from the extension context.
    
    // For example, look for an image and place it into an image view.
    // Replace this with something appropriate for the type[s] your extension supports.
//    BOOL imageFound = NO;
//    for (NSExtensionItem *item in self.extensionContext.inputItems) {
//        for (NSItemProvider *itemProvider in item.attachments) {
//            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
//                // This is an image. We'll load it, then place it in our image view.
//                __weak UIImageView *imageView = self.imageView;
//                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
//                    if(image) {
//                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                            [imageView setImage:image];
//                        }];
//                    }
//                }];
//
//                imageFound = YES;
//                break;
//            }
//        }
//
//        if (imageFound) {
//            // We only handle one image, so stop looking for more.
//            break;
//        }
//    }
//
//    NSString *scheml = @"breath://";
//    NSURL *url = [NSURL URLWithString:scheml];
////    SEL selectorOpenURL = sel_registerName("openURL:");
////    NSExtensionContext *context = [[NSExtensionContext alloc] init];
////    [context openURL:url completionHandler:nil];
////
////    UIResponder *responder = (UIResponder *)self;
////    while (responder != nil) {
////        if ([responder respondsToSelector:selectorOpenURL]) {
////            [responder performSelector:selectorOpenURL withObject:url];
////        }
////        responder = responder.nextResponder;
////    }
////
//
//    [self breathing:url];
//
    
    
}

- (void)openContainerAp:(NSURL *)url {
    UIResponder *responder = (UIResponder *)self;
    SEL selectorOpenURL = sel_registerName("openURL:");
    while (responder != nil) {
        if ([responder respondsToSelector:selectorOpenURL]) {
            [responder performSelector:selectorOpenURL withObject:url];
        }
        responder = responder.nextResponder;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    
    __block BOOL hasExistsUrl = NO;
    [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem * _Nonnull extItem, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [extItem.attachments enumerateObjectsUsingBlock:^(NSItemProvider * _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"])
            {
                [itemProvider loadItemForTypeIdentifier:@"public.url"
                                                options:nil
                                      completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                                          
                                          if ([(NSObject *)item isKindOfClass:[NSURL class]])
                                          {
                                              NSLog(@"分享的URL = %@", item);
                                              NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.enoughoops.Breath"];
                                              NSLog(@"旧的分享 : %@", [userDefaults valueForKey:@"share-url"]);
                                              [userDefaults setValue: ((NSURL *)item).absoluteString forKey:@"share-url"];
                                              NSLog(@"新的分享 : %@", [userDefaults valueForKey:@"share-url"]);
                                              
                                              //查看AppGroup所在的路径
                                              NSString *groupPath =  (NSString *)[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.enoughoops.Breath"];
                                              NSLog(@"groupPathhhhh:%@",groupPath);
                                              //用于标记是新的分享
                                              [userDefaults setBool:YES forKey:@"has-new-share"];
                                              [userDefaults synchronize];
                                              NSLog(@"新的分享 : %@", [userDefaults valueForKey:@"share-url"]);
                                          }
                                          
                                      }];
                
                hasExistsUrl = YES;
                *stop = YES;
            }
            
        }];
        
        if (hasExistsUrl)
        {
            *stop = YES;
        }
    }];

    NSString *scheml = @"breath://";
    NSURL *url = [NSURL URLWithString:scheml];
    [self openContainerAp:url];
    [self done];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
