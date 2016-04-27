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

@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString *companyStockPrice;
@property (nonatomic, retain) NSString *companyTitle;
@property (nonatomic, retain) NSString *companyLogoName;
@property (nonatomic, retain) NSMutableArray *products;

-(instancetype)initWithCompanyName:(NSString*)companyName withCompanyStockPrice:(NSString*)companyStockPrice withCompanyTitle:(NSString*)companyTitle withCompanyLogoName:(NSString*)companyLogoName withProducts:(NSMutableArray*)products;

-(instancetype)initWithCompanyName:(NSString*)companyName withCompanyTitle:(NSString*)companyTitle withCompanyLogoName:(NSString*)companyLogoName withProducts:(NSMutableArray*)products;
@end