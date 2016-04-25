//
//  Product.h
//  NavCtrl
//
//  Created by Macbook Pro on 4/4/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) NSString *productURL;
@property (nonatomic, retain) NSString *productImage;

-(instancetype)initWithCompanyName:(NSString*)companyName withProductName:(NSString*)productName withProductURL:(NSString*)productURL withProductImage:(NSString*)productImage;

@end
