//
//  Product.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithCompanyName:(NSString*)companyName withProductName:(NSString*)productName withProductURL:(NSString*)productURL withProductImage:(NSString *)productImage {
    
    self.companyName = companyName;
    self.productName = productName;
    self.productURL = productURL;
    self.productImage = productImage;
    return self;
    
}

@end
