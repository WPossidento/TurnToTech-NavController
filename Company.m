//
//  Company.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

-(instancetype)initWithCompanyName:(NSString*)companyName withCompanyTitle:(NSString*)companyTitle withCompanyLogoName:(NSString*)companyLogoName withProducts:(NSMutableArray*)products {

    self.companyName = companyName;
    self.companyTitle = companyTitle;
    self.companyLogoName = companyLogoName;
    self.products = products;
    return self;
    
}

@end
