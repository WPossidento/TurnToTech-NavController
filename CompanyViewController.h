//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface CompanyViewController : UITableViewController{
    NSMutableArray *companiesGlobal;
}

@property (nonatomic, retain) NSMutableArray *companies;




@end
