//
//  Product.h
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ProductViewController.h"

@interface Product : NSObject


//FIXME: fix this and use it instead of .notation (I added product_id part)
//-(instancetype)initWithProductName:(NSString*)productName withProductURL:(NSString*)productURL withProductImage:(NSString*)productImage withProduct_id:(NSString*)product_id;
-(instancetype)initWithProductName:(NSString*)productName withProductURL:(NSString*)productURL withProductImage:(NSString*)productImage withProductLocationInTable:(NSNumber*)productLocationInTable;

////FIXME: remove this
//@property (nonatomic, retain) NSString *companyName;

@property (nonatomic, retain) NSString *company_id;
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) NSString *productURL;
@property (nonatomic, retain) NSString *productImage;
@property (nonatomic, retain) NSString *product_id;
@property (nonatomic, retain) NSNumber *productLocationInTable;


@end
