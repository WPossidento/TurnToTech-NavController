//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Product.h"
#import "Company.h"

#import "WebViewController.h"

@interface ProductViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>


//@property(nonatomic, retain) Product *productName;

@property(nonatomic, retain) WebViewController *webViewController;

@property (nonatomic, retain) Company *company;


@end
