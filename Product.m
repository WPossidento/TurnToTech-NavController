//
//  Product.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithProductName:(NSString*)productName withProductURL:(NSString*)productURL withProductImage:(NSString*)productImage withProductLocationInTable:(NSNumber*)productLocationInTable
 {
    
    self.productName = [productName retain];
    self.productURL = [productURL retain];
    self.productImage = [productImage retain];
     
#warning this doesn't work, fix it, set to zero or another number
    self.productLocationInTable = [_productLocationInTable retain];
    return self;
    
}

-(void)dealloc {
    [_productName release];
    [_product_id release];
    [_productURL release];
    [_productImage release];
    [_productLocationInTable release];
    
    [super dealloc];
}

@end
