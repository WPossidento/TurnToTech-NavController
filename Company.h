//
//  Company.h
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompanyViewController.h"

@interface Company : NSObject

@property (nonatomic, retain) NSString *companyId;
@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString *companyTitle;
@property (nonatomic, retain) NSString *companyStockSymbol;
@property (nonatomic, retain) NSString *companyLogoName;
@property (nonatomic, retain) NSMutableArray *products;

@property (nonatomic, retain) NSString *companyStockPrice; // transient property

//FIXME: remove this
//@property (nonatomic, retain) NSString *databasePath;
//FIXME: remove this
//@property (nonatomic, retain) NSMutableArray *companies;


@end