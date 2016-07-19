
//  Company.h
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CompanyViewController.h"

@interface Company : NSObject

@property (nonatomic) int companyId;
@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString *companyStockSymbol;
@property (nonatomic, retain) NSString *companyLogoName;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSNumber *companyLocationInTable;

@property (nonatomic, retain) NSString *companyStockPrice; // transient property

@end