
//  DataAccessObject.m
//  NavCtrl

//  Created by Macbook Pro on 4/6/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.

#import "DataAccessObject.h"
#import "CompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import <CoreData/CoreData.h>
#import "ManagedCompany.h"
#import "ManagedProduct.h"


@implementation DataAccessObject

+(DataAccessObject*) sharedObject {
    
    static DataAccessObject  *sharedDataAccessObject = nil;
    if(!sharedDataAccessObject) {
        sharedDataAccessObject = [[DataAccessObject alloc] init];
        
        // if sqlite database exists at archive patch
        // do fetch
        // else get [sharedDataAccessObject getHardCodedCompaniesAndProducts];
        
    }
    return sharedDataAccessObject;
}

-(instancetype)init{
    self = [super init];
    
    _managedCompanies = [[NSMutableArray alloc] init];
    _companies = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[self archivePath]]) {
        
        [self reloadDataFromContext];
        
    } else {
        
        [self getHardCodedCompaniesAndProducts];
        [self getManagedCompaniesAndManagedProductsFromHardCoded];
        [self.managedObjectContext save:nil];
        
    }

    return self;
}

#pragma mark - hard-coded values
- (void)getHardCodedCompaniesAndProducts {
    
    Company *amazon = [[Company alloc] init];
    amazon.companyName = @"Amazon";
    amazon.companyStockSymbol = @"AMZN";
    amazon.companyLogoName = @"logo_Amazon_48x48.png";
    amazon.companyLocationInTable = [NSNumber numberWithInt:(0)];
    
    Product *echo = [[Product alloc] init];
    echo.productName = @"Echo";
    echo.productURL = @"https://www.amazon.com/Amazon-Echo-Bluetooth-Speaker-with-WiFi-Alexa/dp/B00X4WHP5E/ref=sr_1_1?s=digital-text&ie=UTF8&qid=1466540758&sr=1-1&keywords=echo";
    echo.productImage = @"logo_Amazon_48x48.png";
    echo.productLocationInTable = [NSNumber numberWithInt:(0)];
    Product *kindle = [[Product alloc] init];
    kindle.productName = @"Kindle";
    kindle.productURL = @"http://www.amazon.com/b/?ie=UTF8&node=6669702011";
    kindle.productImage = @"logo_Amazon_48x48.png";
    kindle.productLocationInTable = [NSNumber numberWithInt:(1)];
    Product *web_services = [[Product alloc] init];
    web_services.productName = @"Web Services";
    web_services.productURL = @"http://aws.amazon.com/s/dm/landing-page/join-aws/";
    web_services.productImage = @"logo_Amazon_48x48.png";
    web_services.productLocationInTable = [NSNumber numberWithInt:(2)];
    amazon.products = [[NSMutableArray alloc] initWithObjects:echo, kindle, web_services, nil];
    
    Company *apple = [[Company alloc] init];
    apple.companyName = @"Apple";
    apple.companyStockSymbol = @"AAPL";
    apple.companyLogoName = @"logo_Apple_48x48.jpg";
    apple.companyLocationInTable = [NSNumber numberWithInt:(1)];
   
    Product *iPad = [[Product alloc] init];
    iPad.productName = @"iPad";
    iPad.productURL = @"https://www.apple.com/ipad/";
    iPad.productImage = @"logo_Apple_48x48.jpg";
    iPad.productLocationInTable = [NSNumber numberWithInt:(0)];
    Product *iPod = [[Product alloc] init];
    iPod.productName = @"iPod Touch";
    iPod.productURL = @"https://www.apple.com/ipod-touch/";
    iPod.productImage = @"logo_Apple_48x48.jpg";
    iPod.productLocationInTable = [NSNumber numberWithInt:(1)];
    Product *iPhone = [[Product alloc] init];
    iPhone.productName = @"iPhone";
    iPhone.productURL = @"https://www.apple.com/iphone/";
    iPhone.productImage = @"logo_Apple_48x48.jpg";
    iPhone.productLocationInTable = [NSNumber numberWithInt:(2)];
    apple.products = [[NSMutableArray alloc] initWithObjects:iPad, iPod, iPhone, nil];
    
    Company *google = [[Company alloc] init];
    google.companyName = @"Google";
    google.companyStockSymbol = @"GOOG";
    google.companyLogoName = @"logo_Google_48x48.png";
    google.companyLocationInTable = [NSNumber numberWithInt:(2)];
    
    Product *maps = [[Product alloc] init];
    maps.productName = @"Google Maps";
    maps.productURL = @"https://maps.google.com";
    maps.productImage = @"logo_Google_48x48.png";
    maps.productLocationInTable = [NSNumber numberWithInt:(0)];
    Product *images = [[Product alloc] init];
    images.productName = @"Google Images";
    images.productURL = @"https://images.google.com";
    images.productImage = @"logo_Google_48x48.png";
    images.productLocationInTable = [NSNumber numberWithInt:(1)];
    Product *alerts= [[Product alloc] init];
    alerts.productName = @"Google Alerts";
    alerts.productURL = @"https://www.google.com/alerts";
    alerts.productImage = @"logo_Google_48x48.png";
    alerts.productLocationInTable = [NSNumber numberWithInt:(2)];
    google.products = [[NSMutableArray alloc] initWithObjects:maps, images, alerts, nil];
    
    Company *microsoft = [[Company alloc] init];
    microsoft.companyName = @"Microsoft";
    microsoft.companyStockSymbol = @"MSFT";
    microsoft.companyLogoName = @"logo_Microsoft_48x48.jpg";
    microsoft.companyLocationInTable = [NSNumber numberWithInt:(3)];
   
    Product *lumia_950 = [[Product alloc] init];
    lumia_950.productName = @"Lumia 950";
    lumia_950.productURL = @"http://www.microsoftstore.com/store/msusa/en_US/pdp/ATT--Microsoft-Lumia-950/productID.330607700";
    lumia_950.productImage = @"logo_Microsoft_48x48.jpg";
    lumia_950.productLocationInTable = [NSNumber numberWithInt:(0)];
    Product *lumia_950XL = [[Product alloc] init];
    lumia_950XL.productName = @"Lumia 950XL";
    lumia_950XL.productURL = @"http://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950-XL--Unlocked/productID.326602300";
    lumia_950XL.productImage = @"logo_Microsoft_48x48.jpg";
    lumia_950XL.productLocationInTable = [NSNumber numberWithInt:(1)];
    Product *lumia_650_Dual_Sim = [[Product alloc] init];
    lumia_650_Dual_Sim.productName = @"Lumia 650 Dual Sim";
    lumia_650_Dual_Sim.productURL = @"http://www.microsoftstore.com/store/msusa/en_US/pdp/productID.334960800?icid=US_Lumia__lumia650_031116";
    lumia_650_Dual_Sim.productImage = @"logo_Microsoft_48x48.jpg";
    lumia_650_Dual_Sim.productLocationInTable = [NSNumber numberWithInt:(2)];
    microsoft.products = [[NSMutableArray alloc] initWithObjects: lumia_950, lumia_950XL, lumia_650_Dual_Sim, nil];
    
    self.companies = [NSMutableArray arrayWithArray:@[amazon, apple, google, microsoft]];

}

-(void)getManagedCompaniesAndManagedProductsFromHardCoded {
    NSEntityDescription *entityCompany = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    NSEntityDescription *entityProduct = [NSEntityDescription entityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    
    for (Company *company in self.companies) {
        
        ManagedCompany *managedCompany = (ManagedCompany*)[[NSManagedObject alloc] initWithEntity:entityCompany insertIntoManagedObjectContext:self.managedObjectContext];
        
        [managedCompany setValue:company.companyName forKey:@"companyName"];
        [managedCompany setValue:company.companyStockSymbol forKey:@"companyStockSymbol"];
        [managedCompany setValue:company.companyLogoName forKey:@"companyLogoName"];
        
// #error created managed products and add them to the managed company
        
        for (Product *product in company.products) {
        
//            NSManagedObject *managedProduct = [[NSManagedObject alloc] initWithEntity:entityCompany insertIntoManagedObjectContext:self.managedObjectContext];
            
            ManagedProduct *managedProduct = [[ManagedProduct alloc] initWithEntity:entityProduct insertIntoManagedObjectContext:self.managedObjectContext];
            managedProduct.productName = product.productName;
            managedProduct.productImage = product.productImage;
            managedProduct.productURL = product.productURL;
            managedProduct.productLocationInTable = product.productLocationInTable;
            
            managedProduct.managedCompany = managedCompany;
            
        }
        
        [self.managedCompanies addObject:managedCompany];
        
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.WilliamP.getCoreDataBoilerplate" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"store.data"];
    
    NSLog(@"Database Path: %@", [storeURL absoluteString]);
    
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];

    self.managedObjectContext.undoManager = [[[NSUndoManager alloc] init] autorelease];
    
    return _managedObjectContext;
    
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Physical storage location in device.
-(NSString*) archivePath
{
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"store.data"];
}


-(void) reloadDataFromContext {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSSortDescriptor *sortByCompanyLocationInTable = [[NSSortDescriptor alloc]
                                                      initWithKey:@"companyLocationInTable" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sortByCompanyLocationInTable]];
    
    NSEntityDescription *managedCompany = [[[self managedObjectModel] entitiesByName] objectForKey:@"ManagedCompany"];
    [request setEntity:managedCompany];
    
    NSError *error = nil;
    
    //This gets data only from context, not from store
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!results)
    {
        [NSException raise:@"Fetch Failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    [self.companies removeAllObjects]; // Clears the companies array to re-fill it below.
    [self.managedCompanies removeAllObjects]; // Clears the managedCompanies array to re-fill it below.
    
    // loop through the results
    // create a company for each managed object of type Company
    // add those companies to companies array
    
    for (ManagedCompany *managedObjectCompany in results) {
        Company *company = [[Company alloc] init];
        company.companyName = managedObjectCompany.companyName;
        company.companyStockSymbol = managedObjectCompany.companyStockSymbol;
        company.companyLogoName = managedObjectCompany.companyLogoName;
        
        [company.products removeAllObjects]; // ************ 19 July
        
        for (ManagedProduct *managedObjectProduct in managedObjectCompany.managedProduct) {
            Product *product = [[Product alloc] init];
            product.productName = managedObjectProduct.productName;
            product.productURL = managedObjectProduct.productURL;
            product.productImage = managedObjectProduct.productImage;
            product.productLocationInTable = managedObjectProduct.productLocationInTable;
            
            [company.products addObject:product];
            
        }
        
        // sort the products in both company and managedcompany
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"productLocationInTable" ascending:YES];
        company.products = [NSMutableArray arrayWithArray:[company.products sortedArrayUsingDescriptors:@[descriptor]]];
        
        NSArray *array = [(NSSet*)managedObjectCompany.managedProduct sortedArrayUsingDescriptors:@[descriptor]];
        managedObjectCompany.managedProduct  = [[NSMutableOrderedSet alloc] initWithArray:array];
        
        [self.companies addObject:company];
        [self.managedCompanies addObject:managedObjectCompany];
        
    }
    
}

// On calling this, actual saving is done in the Core Data table
-(void) saveChanges
{
    NSError *err = nil;
    BOOL successful = [[self managedObjectContext] save:&err];
    if(!successful)
    {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    NSLog(@"Data Saved");
}

// Loads all companies from Core Data Company table into tableview datasource.
-(void) loadAllCompanies
{
    
    [self reloadDataFromContext];
    
}

#pragma mark --- Data operations

// Creating a member then save it to Company table and tableview datasource.
-(void)createCompanyWithName:(NSString *)companyName companyStockSymbol:(NSString *)companyStockSymbol companyLogoName:(NSString *)companyLogoName companyLocationInTable:(NSNumber *)companyLocationInTable {
    
    //Add this object to the context. Nothing happens till it is saved
    ManagedCompany *managedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:[self managedObjectContext]];
    
    [managedCompany setCompanyName: companyName];
    [managedCompany setCompanyStockSymbol: companyStockSymbol];
    [managedCompany setCompanyLogoName: companyLogoName];
    [managedCompany setCompanyLocationInTable:companyLocationInTable];
    
//    Create a non managed company and insert it here
//    Company *company = [[Company alloc] init];
//    [[self companies] addObject:company];

//  Add the managed company to the managed companies array
    [[self managedCompanies] addObject:managedCompany];
    
}

-(void)addProduct:(NSString *)productName productURL:(NSString *)productURL productImage:(NSString *)productImage forCompany:(Company*)company
{
    //native product
    
    NSUInteger indexOfCompany = [self.companies indexOfObject:company];
    ManagedCompany *mc = [self.managedCompanies objectAtIndex:indexOfCompany];
    
//#error create non managed product, add it to non-managed company
    
    Product *product = [[Product alloc] init];
    product.productName = productName;
    product.productURL = productURL;
    product.productImage = productImage;
    
    [company.products addObject:product];

    ManagedProduct *managedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    
    managedProduct.productName = product.productName;
    managedProduct.productURL = product.productURL;
    managedProduct.productImage = product.productImage;
    managedProduct.productLocationInTable = product.productLocationInTable;
    
    [managedProduct setManagedCompany:mc];
    
    [[self managedCompanies] addObject:managedProduct];
  
}

// Delete company from table and tableview datasource.
-(void)deleteCompany:(int)index {
    
//  #error get the managed company from the other array
    ManagedCompany *managedCompany = [[self managedCompanies] objectAtIndex:index];
    
    //Remove object from context
    [[self managedObjectContext] deleteObject:managedCompany];
    
    [[self managedCompanies] removeObjectAtIndex:index];
}

// Delete product from table
-(void)deleteProduct:(int)index forCompany:(Company*)company {
    
    NSUInteger indexOfCompany = [self.companies indexOfObject:company];
    ManagedCompany *mc = [self.managedCompanies objectAtIndex:indexOfCompany];
    NSMutableOrderedSet *products = mc.managedProduct;
    ManagedProduct *mp = [products objectAtIndex:index];
    
    mp.managedCompany = nil;
    [self.managedObjectContext deleteObject:mp];
    
}

- (void)modifyCompany:(Company*)modifiedCompany {
    
    NSUInteger index = [self.companies indexOfObject:modifiedCompany];
    ManagedCompany *managedCompany = [self.managedCompanies objectAtIndex:index];
    
//  #error update the properties on managed object from modifed non-managed company
    // update all properties from non-managed to managed
    managedCompany.companyName = modifiedCompany.companyName;
    managedCompany.companyStockSymbol = modifiedCompany.companyStockSymbol;
    managedCompany.companyLogoName = modifiedCompany.companyLogoName;
    managedCompany.companyLocationInTable = modifiedCompany.companyLocationInTable;
    
}

-(void)modifyProduct:(int)index forCompany:(Company*)company forProduct:(Product*)product {
    
    NSUInteger indexOfCompany = [self.companies indexOfObject:company];
    ManagedCompany *mc = [self.managedCompanies objectAtIndex:indexOfCompany];
    NSMutableOrderedSet *products = mc.managedProduct;
    NSManagedObject *mp = [products objectAtIndex:index];
    
    [mp setValue:product.productName forKey:@"productName"];
    [mp setValue:product.productURL forKey:@"productURL"];
    [mp setValue:product.productImage forKey:@"productImage"];
    
}

-(void) undoLastAction { // to undo re-arranging, editing, adding, or deleting of companies or products
    
    [self.managedObjectContext undo];
    
    [self reloadDataFromContext];
   
}

@end



