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

    NSString *productURL = @"";

        if ([self.title isEqualToString:@"iPad"]) {
            productURL = @"http://www.apple.com/ipad-pro/";
        } else if ([self.title isEqualToString:@"iPod Touch"]) {
            productURL = @"http://www.apple.com/ipod/compare-ipod-models/";
        } else if ([self.title isEqualToString:@"iPhone"]) {
            productURL = @"http://www.apple.com/iphone/";
        } else if ([self.title isEqualToString:@"Galaxy S7"]) {
            productURL = @"http://www.samsung.com/us/mobile/cell-phones/SM-G935AZDAATT";
        } else if ([self.title isEqualToString:@"Galaxy Note"]) {
            productURL = @"http://www.samsung.com/us/mobile/cell-phones/SM-N920AZDEATT";
        } else if ([self.title isEqualToString:@"Galaxy Tab"]) {
            productURL = @"http://www.samsung.com/us/mobile/galaxy-tab/SM-T230NZWAXAR";
        } else if ([self.title isEqualToString:@"Lumia 950"]) {
            productURL = @"http://www.microsoftstore.com/store/msusa/en_US/pdp/ATT--Microsoft-Lumia-950/productID.330607700";
        } else if ([self.title isEqualToString:@"Lumia 950 XL"]) {
            productURL = @"http://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950-XL--Unlocked/productID.326602300";
        } else if ([self.title isEqualToString:@"Lumia 650 Dual Sim"]) {
            productURL = @"http://www.microsoftstore.com/store/msusa/en_US/pdp/productID.334960800?icid=US_Lumia__lumia650_031116";
        } else if ([self.title isEqualToString:@"HTC One A9"]) {
            productURL = @"https://www.htc.com/us/smartphones/htc-one-a9/";
        } else if ([self.title isEqualToString:@"HTC One M9"]) {
            productURL = @"https://www.htc.com/us/smartphones/htc-one-m9/";
        } else if ([self.title isEqualToString:@"HTC Desire 626"]) {
            productURL = @"https://www.htc.com/us/smartphones/htc-desire-626/";
        }

    
    NSURL *myURL = [NSURL URLWithString:productURL];

    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
    [myWebView loadRequest:myRequest];
    
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
