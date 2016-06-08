//
//  Product.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

//-(instancetype)initWithProductName:(NSString*)productName withProductURL:(NSString*)productURL withProductImage:(NSString*)productImage withProduct_id:(NSString*)product_id;
-(instancetype)initWithProductName:(NSString*)productName withProductURL:(NSString*)productURL withProductImage:(NSString*)productImage
 {
    
//    self.companyName = companyName;
    self.productName = productName;
    self.productURL = productURL;
    self.productImage = productImage;
    self.product_id = _product_id;
    return self;
    
}

-(void)dealloc {
    [_productName release];
    [_product_id release];
    [_productURL release];
    [_productImage release];
    [super dealloc];
}

@end
