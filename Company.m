//
//  Company.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.


#import "Company.h"
//#import "CompanyViewController.h"

// Do not put ANY SQlite anywhere except in the DAO.

@implementation Company

-(instancetype)init {
    
    self = [super init];
    _products = [[NSMutableArray alloc] init];
    return self;
}

-(void) dealloc {
//    [_companyId release];
    [_companyName release];
    [_companyLogoName release];
    [_companyStockPrice release];
    [_companyStockSymbol release];
    [_products release];
    [_companyLocationInTable release];
    
    [super dealloc];
}


@end