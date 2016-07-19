
//  ManagedCompany+CoreDataProperties.h
//  NavCtrl
//
//  Created by Macbook Pro on 7/7/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedCompany.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedCompany (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *companyLocationInTable;
@property (nullable, nonatomic, retain) NSString *companyLogoName;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSString *companyStockSymbol;
@property (nullable, nonatomic, retain) NSMutableOrderedSet<ManagedProduct *> *managedProduct;

@end

@interface ManagedCompany (CoreDataGeneratedAccessors)

- (void)insertObject:(ManagedProduct *)value inManagedProductAtIndex:(NSUInteger)idx;
- (void)removeObjectFromManagedProductAtIndex:(NSUInteger)idx;
- (void)insertManagedProduct:(NSArray<ManagedProduct *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeManagedProductAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInManagedProductAtIndex:(NSUInteger)idx withObject:(ManagedProduct *)value;
- (void)replaceManagedProductAtIndexes:(NSIndexSet *)indexes withManagedProduct:(NSArray<ManagedProduct *> *)values;
- (void)addManagedProductObject:(ManagedProduct *)value;
- (void)removeManagedProductObject:(ManagedProduct *)value;
- (void)addManagedProduct:(NSOrderedSet<ManagedProduct *> *)values;
- (void)removeManagedProduct:(NSOrderedSet<ManagedProduct *> *)values;

@end

NS_ASSUME_NONNULL_END
