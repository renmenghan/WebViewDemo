//
//  UIWebView-JSExport.m
//  WebViewDemo
//
//  Created by 任梦晗 on 2020/5/5.
//  Copyright © 2020 任梦晗. All rights reserved.
//

#import "UIWebViewJSExport.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>

JSExportAs(jsToOc, - (void)jsToOc:(NSString *)action params:(NSString *)param);


@end
@interface UIWebViewJSExport ()<UIWebViewDelegate,JSObjcDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UIWebViewJSExport

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
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"UIWebView-JSExport" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}

// 分享 OC调用js方法
- (void)share:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        //! JSContext -evaluateScript:方式调用JS方法
        // [context evaluateScript:[NSString stringWithFormat:@"ocToJs('shareSucceed', 'shareContent')"]];
        
        //! JSValue -callWithArguments:方式调用JS方法
        [context[@"ocToJs"] callWithArguments:@[@"shareSucceed", @"shareContent"]];
    });
}


- (void)jsToOc:(NSString *)action params:(NSString *)param
{
    dispatch_async(dispatch_get_main_queue(), ^{
       [self showAlertViewWithTitle:action message:param];
    });
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.title = [context evaluateScript:@"document.title"].toString;
    
    context[@"RMHApp"] = self;
}

@end
