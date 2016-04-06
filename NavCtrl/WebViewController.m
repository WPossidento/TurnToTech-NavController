//-------
//  WebViewController.m
//  NavCtrl
//
//  Created by Macbook Pro on 3/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "ProductViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    NSURL *myURL = [NSURL URLWithString:_productURL]; // Converts string (_productURL) to URL (*myURL).

    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
// This is for the old UIWebView:
//    [myWebView loadRequest:myRequest];
    
// Had to go to Project, click on General, scroll down to Linked Frameworks and Libraries, and add WebKit.framework as Optional to permit WKWebView:
    _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    [_wkWebView loadRequest:myRequest];
    
    _wkWebView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_wkWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
