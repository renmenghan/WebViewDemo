//
//  WebViewMessageHandler.m
//  WebViewDemo
//
//  Created by 任梦晗 on 2020/5/5.
//  Copyright © 2020 任梦晗. All rights reserved.
//

#import "WebViewMessageHandler.h"
#import "UIWebViewWVJSBridge.h"
@implementation WebViewMessageHandler

- (void)registerHandlersForJSBridge:(WebViewJavascriptBridge *)bridge {
    
    NSMutableArray *handlerNames = @[@"jsToOc"].mutableCopy;

    [handlerNames addObjectsFromArray:[self specialHandlerNames]];
    
    for (NSString *aHandlerName in handlerNames) {
        [bridge registerHandler:aHandlerName handler:^(id data, WVJBResponseCallback responseCallback) {
            
            NSMutableDictionary *args = [NSMutableDictionary dictionary];
            
            if ([data isKindOfClass:[NSDictionary class]]) {
                [args addEntriesFromDictionary:data];
            }
            
            if (responseCallback) {
                [args setObject:responseCallback forKey:@"responseCallback"];
            }
            
            
            NSString *ObjCMethodName = [aHandlerName stringByAppendingString:@":"];
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:NSSelectorFromString(ObjCMethodName) withObject:args];
#pragma clang diagnostic pop
            
        }];
    }
}

- (NSArray *)specialHandlerNames
{
    return @[];
}

- (void)jsToOc:(NSDictionary *)args
{
    NSString *shareContent = [NSString stringWithFormat:@"标题：%@\n 内容：%@ \n url：%@",
                                 args[@"title"],
                                 args[@"content"],
                                 args[@"url"]];
    [self.controller showAlertViewWithTitle:@"点击按钮调用原生方法" message:shareContent];
}



@end
