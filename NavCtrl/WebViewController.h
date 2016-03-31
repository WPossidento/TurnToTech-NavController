//
//  WebViewController.h
//  NavCtrl
//
//  Created by Macbook Pro on 3/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//#import "ProductViewController.h"

@interface WebViewController : UIViewController

{
    IBOutlet UIWebView *myWebView;
}

@property (nonatomic, retain) NSArray *products;

// Added for switch to WKWebView:
@property(strong,nonatomic) WKWebView *wkWebView;


//@property (nonatomic, retain) ProductViewController *productViewController;


@end
