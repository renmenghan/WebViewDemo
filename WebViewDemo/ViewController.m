//
//  ViewController.m
//  WebViewDemo
//
//  Created by 任梦晗 on 2020/5/5.
//  Copyright © 2020 任梦晗. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewJSCore.h"
#import "UIWebViewJSExport.h"
#import "UIWebViewWVJSBridge.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *titleArray;;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"UIWebView-JavaScriptCore",@"UIWebView-JSExport",@"WebViewJavascriptBridge"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"webviewdemo"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = self.titleArray[indexPath.row]?:@"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UIWebViewJSCore *vc = [[UIWebViewJSCore alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
        UIWebViewJSExport *vc = [[UIWebViewJSExport alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row == 2){
        UIWebViewWVJSBridge *vc = [[UIWebViewWVJSBridge alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

@end
