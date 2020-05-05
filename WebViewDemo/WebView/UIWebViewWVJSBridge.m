//
//  UIWebViewWVJSBridge.m
//  WebViewDemo
//
//  Created by 任梦晗 on 2020/5/5.
//  Copyright © 2020 任梦晗. All rights reserved.
//

#import "UIWebViewWVJSBridge.h"
#import "WebViewJavascriptBridge.h"
#import "WebViewMessageHandler.h"
@interface UIWebViewWVJSBridge ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation UIWebViewWVJSBridge

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
}

- (void)initUI
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    if (@available(ios 11.0,*)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIBarButtonItem *shareBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItems = @[shareBtnItem];
}

- (void)initData
{
    // 创建 WebViewJavascriptBridge 对象
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    WebViewMessageHandler *handler = [[WebViewMessageHandler alloc] init];
    handler.controller = self;
    [handler registerHandlersForJSBridge:self.bridge];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"UIWebView-WebViewJSBridge" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [_webView loadRequest:request];
}

// 分享 OC调用js方法
- (void)share:(id)sender {
    [self.bridge callHandler:@"ocToJs" data:@{@"content":@"1111"} responseCallback:^(id responseData) {
        NSString *shareContent = [NSString stringWithFormat:@"标题：%@\n 内容：%@ \n url：%@",
                                         responseData[@"title"],
                                         responseData[@"content"],
                                         responseData[@"url"]];
        [self showAlertViewWithTitle:@"oc调用js之后回调" message:shareContent];
    }];
   
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}


@end
