//
//  WebViewMessageHandler.h
//  WebViewDemo
//
//  Created by 任梦晗 on 2020/5/5.
//  Copyright © 2020 任梦晗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewJavascriptBridge.h"
@class UIWebViewWVJSBridge;
NS_ASSUME_NONNULL_BEGIN

@interface WebViewMessageHandler : NSObject

@property (nonatomic,strong) UIWebViewWVJSBridge *controller;

/// 注册 handler
- (void)registerHandlersForJSBridge:(WebViewJavascriptBridge *)bridge;

/// 要注册的特定 handler name，子类重写
- (NSArray *)specialHandlerNames;
@end

NS_ASSUME_NONNULL_END
