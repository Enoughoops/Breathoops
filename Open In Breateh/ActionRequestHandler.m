//
//  ActionRequestHandler.m
//  Open In Breateh
//
//  Created by LinMo on 2018/1/5.
//  Copyright © 2018年 LinMo. All rights reserved.
//

#import "ActionRequestHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BNRWebViewController.h"

@interface ActionRequestHandler ()

@property (nonatomic, strong) NSExtensionContext *extensionContext;

@end

@implementation ActionRequestHandler

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context {
    // Do not call super in an Action extension with no user interface
    self.extensionContext = context;

    BOOL found = NO;

    // Find the item containing the results from the JavaScript preprocessing.
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypePropertyList]) {
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypePropertyList options:nil completionHandler:^(NSDictionary *dictionary, NSError *error) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self itemLoadCompletedWithPreprocessingResults:dictionary[NSExtensionJavaScriptPreprocessingResultsKey]];
                    }];
                }];
                found = YES;
            }
            break;
        }
        if (found) {
            break;
        }
    }

    if (!found) {
        // We did not find anything
        [self doneWithResults:nil];
    }
    
//    NSString *scheml = @"breath://";
//    NSURL *appUrl = [NSURL URLWithString:scheml];
////    SEL selectorOpenURL = sel_registerName("openURL:");
//    NSExtensionContext *myContext = [[NSExtensionContext alloc] init];
//   [myContext openURL:appUrl completionHandler:nil];
//
//
//
//    BNRWebViewController *wvc = [[BNRWebViewController alloc]init];
//    [wvc openURL:appUrl];
    

    
    
//    UIApplication *application = (UIApplication *)self;
//    UIResponder *responder = (UIResponder *)self;
//    while (application != nil) {
//        if ([application respondsToSelector:@selector(openURL:)]) {
//            [application performSelector:@selector(openURL:) withObject:appUrl];
//        }
//        responder = responder.nextResponder;
//    }

    
    NSURL *destinationURL = [NSURL URLWithString:@"breath://"];
    

    // Get "UIApplication" class name through ASCII Character codes.
    NSString *className = [[NSString alloc] initWithData:[NSData dataWithBytes:(unsigned char []){0x55, 0x49, 0x41, 0x70, 0x70, 0x6C, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E} length:13] encoding:NSASCIIStringEncoding];
    
    if (NSClassFromString(className))
    {

        UIApplication *object = [NSClassFromString(className) performSelector:@selector(sharedApplication)];
//        id object = [NSClassFromString(className) performSelector:@selector(sharedApplication)];
        [object performSelector:@selector(openURL:) withObject:destinationURL];
    }
    


}

- (void)itemLoadCompletedWithPreprocessingResults:(NSDictionary *)javaScriptPreprocessingResults {
    // Here, do something, potentially asynchronously, with the preprocessing
    // results.
    
    // In this very simple example, the JavaScript will have passed us the
    // current background color style, if there is one. We will construct a
    // dictionary to send back with a desired new background color style.
    if ([javaScriptPreprocessingResults[@"currentBackgroundColor"] length] == 0) {
        // No specific background color? Request setting the background to red.
        [self doneWithResults:@{ @"newBackgroundColor": @"red" }];
    } else {
        // Specific background color is set? Request replacing it with green.
        [self doneWithResults:@{ @"newBackgroundColor": @"green" }];
    }
}

- (void)doneWithResults:(NSDictionary *)resultsForJavaScriptFinalize {
    if (resultsForJavaScriptFinalize) {
        // Construct an NSExtensionItem of the appropriate type to return our
        // results dictionary in.
        
        // These will be used as the arguments to the JavaScript finalize()
        // method.
        
        NSDictionary *resultsDictionary = @{ NSExtensionJavaScriptFinalizeArgumentKey: resultsForJavaScriptFinalize };
        
        NSItemProvider *resultsProvider = [[NSItemProvider alloc] initWithItem:resultsDictionary typeIdentifier:(NSString *)kUTTypePropertyList];
        
        NSExtensionItem *resultsItem = [[NSExtensionItem alloc] init];
        resultsItem.attachments = @[resultsProvider];
        
        // Signal that we're complete, returning our results.
        [self.extensionContext completeRequestReturningItems:@[resultsItem] completionHandler:nil];
    } else {
        // We still need to signal that we're done even if we have nothing to
        // pass back.
        [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
    }
    
    // Don't hold on to this after we finished with it.
    self.extensionContext = nil;
}

@end
