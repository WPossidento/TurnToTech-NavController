
//  DataAccessObject.m
//  NavCtrl

//  Created by Macbook Pro on 4/6/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.

//  What is a Data Access Object?

//  In computer software, a data access object (DAO) is an object that provides an abstract interface to some type of database or other persistence mechanism. By mapping application calls to the persistence layer, the DAO provide some specific data operations without exposing details of the database.

//  MVC (from "model view controller") is a software design pattern common in object-oriented programming languages.

//  MVC is undoubtedly the most used design pattern of all, according to https://www.raywenderlich.com/46988/ios-design-patterns.

//  MODEL: has data and objects like email addresses or phone numbers.
//  VIEW: includes any UI element (buttons, sliders, text fields, table views).
//  CONTROLLER: what joins the app and mediates between the model and view (the model and view cannot talk to each other). Takes the data and displays it on the view.
//  ACTIONS are connections from the view to the controller: they tell the view to talk to the controller, eg, when a button is pressed.
//  OUTLETS are connections from the controller to the view:

//  The MVC pattern should allow for changing the model without affecting the view and changing the view without affecting the model.
//  http://i.stack.imgur.com/RE2ZP.jpg
//  http://www.raywenderlich.com/wp-content/uploads/2013/07/mvc0.png

//  It all comes down to code separation and reusability. Ideally, the View should be completely separated from the Model. If the View doesn’t rely on a specific implementation of the Model, then it can be reused with a different model to present some other data.

//  For example, if in the future you’d also like to add movies or books to your library, you could still use the same AlbumView to display your movie and book objects. Furthermore, if you want to create a new project that has something to do with albums, you could simply reuse your Album class, because it’s not dependent on any view. That’s the strength of MVC!

//  The SINGLETON Pattern

//  The Singleton design pattern ensures that only one INSTANCE exists for a given CLASS and that there’s a global access point to that instance. It usually uses lazy loading to create the single instance when it’s needed the first time.

//  Note: Apple uses this approach a lot. For example: [NSUserDefaults standardUserDefaults], [UIApplication sharedApplication], [UIScreen mainScreen], [NSFileManager defaultManager] all return a Singleton object.

//  You’re likely wondering why you care if there’s more than one instance of a class floating around. Code and memory is cheap, right?

//  There are some cases in which it makes sense to have exactly one instance of a class. For example, there’s no need to have multiple Logger instances out there, unless you want to write to several log files at once. Or, take a global configuration handler class: it’s easier to implement a thread-safe access to a single shared resource, such as a configuration file, than to have many class modifying the configuration file possibly at the same time.

//  http://www.cocoawithlove.com/2008/11/singletons-appdelegates-and-top-level.html: A singleton is an object that can be allocated only once (and can't be deleted) — making it a single, global instance. While singletons are stored in a true global variable, they are never accessed that way in Objective-C (a class method is used to access them), providing a least some abstraction around the implementation.

//  It’s quite common to use SQLite databases in iPhone apps to serve as the backend for your product. While there is a way to create the database file dynamically from your objective-c code, it’s way simpler to create it in your Mac development machine, add it to your Xcode project, and then simply write the code to copy the database file from your app bundle to your app’s document directory (from http://pessoal.org/blog/2009/02/24/iphone-sdk-setting-up-a-sqlite-database-before-first-use/ ).


#import "DataAccessObject.h"
#import "Company.h"
#import "Product.h"
#import "sqlite3.h"

@interface DataAccessObject() {
    sqlite3 * companyDB;
}
@end

@implementation DataAccessObject

+(DataAccessObject*) sharedObject {
    
    static DataAccessObject  *sharedDataAccessObject = nil;
    if(!sharedDataAccessObject) {
        sharedDataAccessObject = [[DataAccessObject alloc] init];
    }
    return sharedDataAccessObject;
}

-(instancetype)init {
    self = [super init];
    [self createCompaniesAndTheirProducts];
    return self;
}

-(void)createCompaniesAndTheirProducts{
    [self copyDBToFinalPath];
    [self getCompanyData];
    
}

//  It’s quite common to use SQLite databases in iPhone apps to serve as the backend for your product. While there is a way to create the database file dynamically from your objective-c code, it’s way simpler to create it in your Mac development machine, add it to your Xcode project, and then simply write the code to copy the database file from your app bundle to your app’s document directory (from http://pessoal.org/blog/2009/02/24/iphone-sdk-setting-up-a-sqlite-database-before-first-use/ ). So in copyDBToFinalPath I COPY THE DATABASE FILE FROM MY APP BUNDLE TO MY APP'S DOCUMENT DIRECTORY.

// To make changes to the database, copy it to the document directory. And use the database in the document directory and not the one in the main bundle. Only use the one in the main bundle as a payload file to be copied to the document directory if there is no file there.

- (void)copyDBToFinalPath {
    NSString *dbBundlePath = [[NSBundle mainBundle] pathForResource:@"NavCtrlDB" ofType:@"db"];
    NSArray *documentsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.dbPath = [NSString stringWithFormat:@"%@%@", [documentsDir objectAtIndex:0], @"/NavCtrlDB.db"];
    NSLog(@"the dbPath is %@", self.dbPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.dbPath]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] copyItemAtPath:dbBundlePath toPath:self.dbPath error:&error];
        if (error) {
            NSLog(@"error = %@", error);

        }
    }
}

-(void)getCompanyData {
    NSMutableArray *companiesLocal = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([_dbPath UTF8String], &companyDB)==SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Company"];
        const char *query_sql = [querySQL UTF8String];
        if (sqlite3_prepare(companyDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *companyId = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *companyName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *companyTitle = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *companyLogoName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                
                Company *company = [[Company alloc]init];
                company.companyId = companyId;
                company.companyName = companyName;
                company.companyTitle = companyTitle;
                company.companyLogoName = companyLogoName;
                
                [companiesLocal addObject:company];
            }
        }
        
        sqlite3_close(companyDB);
    }
    
    self.companies = companiesLocal;
    
    for(Company *c in self.companies){
        [self getProductsData:c];
    }
}


-(void)addCompany:(Company *)company {
    char *error;
    if(sqlite3_open([self.dbPath UTF8String], &companyDB) == SQLITE_OK)
    {
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO COMPANY (companyName, companyTitle, companyLogoName) VALUES ('%@', '%@', '%@')", company.companyName, company.companyTitle, company.companyLogoName];
        
        const char *insert_stmt = [insertStmt UTF8String];
        if (sqlite3_exec(companyDB, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
        {
            
            [self.companies addObject:company];
            NSLog(@"company added");
            
        }
    }
}


-(void)editCompany:(Company*)company{
    
    sqlite3_stmt *updateStatement;
    if(sqlite3_open([_dbPath UTF8String], &companyDB) == SQLITE_OK)
    {
        NSString *querySql=[NSString stringWithFormat:@"UPDATE Company SET companyName='%@', companyTitle='%@' WHERE id='%@'", company.companyName, company.companyTitle, company.companyId];
        
        const char*sql=[querySql UTF8String];
        if(sqlite3_prepare(companyDB,sql, -1, &updateStatement, NULL) == SQLITE_OK)
        {
            if(SQLITE_DONE != sqlite3_step(updateStatement))
            {
                NSLog(@"Error while updating. '%s'", sqlite3_errmsg(companyDB));
            }
            else {
                sqlite3_reset(updateStatement);
                NSLog(@"Company updated");
            }
        }
        
        sqlite3_finalize(updateStatement);
    }
    
//    sqlite3_close(companyDB);
    
}


-(void)deleteCompany:(NSString *)companyId {
    
    char *error;
    NSString * deleteQuery = [NSString stringWithFormat:@"DELETE FROM Company where id = '%@'", companyId];
    
    // Execute the query
    if (sqlite3_exec(companyDB, [deleteQuery UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"company deleted");
    }
//        sqlite3_close(companyDB);
}


-(void)getProductsData:(Company *)company {
    
    NSMutableArray *productsLocal = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([_dbPath UTF8String], &companyDB)==SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Product where company_id = %@", company.companyId];
        const char *query_sql = [querySQL UTF8String];
        if (sqlite3_prepare(companyDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *company_id = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *productName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *productURL = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *productImage = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *product_id = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                
                Product *product = [[Product alloc]init];
                product.company_id = company_id;
                product.productName = productName;
                product.productURL = productURL;
                product.productImage = productImage;
                product.product_id = product_id;
                
                [productsLocal addObject:product];
                NSLog(@"Product added");
                
            }
        }
        
        sqlite3_close(companyDB);
    }
    
    company.products = productsLocal;
}

- (void)addProduct:(Product *)product toCompany:(Company*)company {
    
    // get company from companylist array in DAO.
    // then add product to that company's product list.
    // then in [product] table view controller, reload data.
    
    //forin

    
    [company.products addObject: product];
    product.company_id = company.companyId;
    product.product_id = [NSString stringWithFormat:@"%lu", (unsigned long)company.products.count];
    
    char *error;
    if(sqlite3_open([self.dbPath UTF8String], &companyDB) == SQLITE_OK)
    {
    NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PRODUCT (company_id, productName, productURL, productImage, product_id) VALUES ('%@', '%@', '%@', '%@','%@')", product.company_id, product.productName, product.productURL, product.productImage, product.product_id];
        
        const char *insert_stmt = [insertStmt UTF8String];
//        NSLog(@"sqlite3_exec for product is %d",sqlite3_exec(companyDB, insert_stmt, NULL, NULL, &error));//
        int sqlStatus = sqlite3_exec(companyDB, insert_stmt, NULL, NULL, &error);
        if (sqlStatus == SQLITE_OK)
        {

            NSLog(@"product added");
        }
    }
}

-(void)editProduct:(Product *)product {

        sqlite3_stmt *updateStatement;
        if(sqlite3_open([_dbPath UTF8String], &companyDB) == SQLITE_OK)
        {
            NSString *querySql=[NSString stringWithFormat:@"UPDATE Product SET productName='%@', productURL='%@' WHERE product_id='%@'", product.productName, product.productURL, product.product_id];
            
            const char*sql=[querySql UTF8String];
            if(sqlite3_prepare(companyDB,sql, -1, &updateStatement, NULL) == SQLITE_OK)
            {
                if(SQLITE_DONE != sqlite3_step(updateStatement))
                {
                    NSLog(@"Error while updating. '%s'", sqlite3_errmsg(companyDB));
                }
                else {
                    sqlite3_reset(updateStatement);
                    NSLog(@"Product updated");
                }
            }
            
            sqlite3_finalize(updateStatement);
        }
    
        sqlite3_close(companyDB);
    
}

-(void)deleteProduct:(Product *)product {
    
        char *error;
        NSString * deleteQuery = [NSString stringWithFormat:@"DELETE FROM Product where productName = '%@'", product.productName];
    
        // Execute the query
        if (sqlite3_exec(companyDB, [deleteQuery UTF8String], NULL, NULL, &error) == SQLITE_OK) {
            NSLog(@"product deleted");
    }
    
        sqlite3_close(companyDB);
    
}

@end



