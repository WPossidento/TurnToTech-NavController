
//  DataAccessObject.h
//  NavCtrl

//  Created by Macbook Pro on 4/6/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
//#import "CompanyViewController.h"
#import <CoreData/CoreData.h>


@interface DataAccessObject : NSObject

// @property (nonatomic, retain) NSMutableArray *products; // add this?
@property (nonatomic, retain) NSMutableArray<Company*> *companies;
@property (nonatomic, retain) NSString *dbPath;
@property (nonatomic, assign) Company *currentCompany;
@property (nonatomic, retain) NSMutableArray *stockPrices;

@property (nonatomic) int companyLocationInTable;


+(DataAccessObject*) sharedObject;

#pragma mark - hard-coded values
- (void)getHardCodedCompaniesAndProducts;

#pragma mark - get Managed Companies & Managed Products from Hard Coded
-(void)getManagedCompaniesAndManagedProductsFromHardCoded;

@property (strong, nonatomic) UIWindow *window;

// Core Data boilerplate:
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSMutableArray *managedCompanies;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// CRUD Methods:
// Create
-(void)createCompanyWithName:(NSString *)companyName companyStockSymbol:(NSString *)companyStockSymbol companyLogoName:(NSString *)companyLogoName companyLocationInTable:(NSNumber*)companyLocationInTable;

-(void)addProduct:(NSString *)productName productURL:(NSString *)productURL productImage:(NSString *)productImage forCompany:(Company*)company;

// Read
-(void)loadAllCompanies;

// Update
-(void)modifyCompany:(Company*)modifiedCompany;
-(void)modifyProduct:(int)index forCompany:(Company*)company forProduct:(Product*)product;

-(void)undoLastAction;

// Delete
-(void)deleteProduct:(int)index forCompany:(Company*)company;
-(void)saveChanges;

@property (readonly, nonatomic) int *selectedCompanyIndex;
@property (readonly, nonatomic) BOOL *editingMode;



@end
