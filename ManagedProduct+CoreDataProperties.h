//
//  ManagedProduct+CoreDataProperties.h
//  NavCtrl
//
//  Created by Macbook Pro on 7/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedProduct (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *productImage;
@property (nullable, nonatomic, retain) NSNumber *productLocationInTable;
@property (nullable, nonatomic, retain) NSString *productName;
@property (nullable, nonatomic, retain) NSString *productURL;
@property (nullable, nonatomic, retain) ManagedCompany *managedCompany;

@end

NS_ASSUME_NONNULL_END
