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

   // NSURLRequest objects represent a URL load request in a manner independent of protocol and URL scheme. NSURLRequest encapsulates two basic data elements of a load request: the URL to load, and the policy to use when consulting the URL content cache made available by the implementation.
    
// This is for the old UIWebView:
//    [myWebView loadRequest:myRequest];
    
// Had to go to Project, click on General, scroll down to Linked Frameworks and Libraries, and add WebKit.framework as Optional to permit WKWebView:
    _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    
   
    
    _wkWebView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_wkWebView];

}

-(void)viewWillAppear:(BOOL)animated {
    NSURL *myURL = [NSURL URLWithString:_productURL]; // Converts string (_productURL) to URL (*myURL).
    
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    [_wkWebView loadRequest:myRequest];
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
