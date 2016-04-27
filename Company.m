//
//  Company.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"
#import "CompanyViewController.h"

@implementation Company

-(instancetype)initWithCompanyName:(NSString*)companyName withCompanyStockPrice:(NSString*)companyStockPrice withCompanyTitle:(NSString*)companyTitle withCompanyLogoName:(NSString*)companyLogoName withProducts:(NSMutableArray*)products {
   // if (self = [super init]) { // equivalent to "self does not equal nil"
    self = [super init]; // Needs to init the Object correctly
    if(self) {
        _companyName = [companyName retain];
        _companyTitle = companyTitle;
        [_companyTitle retain];
        _companyLogoName = [companyLogoName retain];
        _products = products;
        [_products retain];
    }
    return self;
}

-(instancetype)initWithCompanyName:(NSString*)companyName withCompanyTitle:(NSString*)companyTitle withCompanyLogoName:(NSString*)companyLogoName withProducts:(NSMutableArray*)products {

    return [self initWithCompanyName:companyName withCompanyStockPrice:nil withCompanyTitle:companyTitle withCompanyLogoName:companyLogoName withProducts:products];
}

@end
