
//  DataAccessObject.h
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


#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "CompanyViewController.h"
#import "sqlite3.h"

@interface DataAccessObject : NSObject

//@property (nonatomic, retain) NSMutableArray *products; // add this?
@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSString *dbPath;
@property (nonatomic, retain) Company * currentCompany;


+(DataAccessObject*) sharedObject;

- (void)copyDBToFinalPath;

// Patrick told me to add 6 methods (for adding, editing and deleting companies and for adding, editing and deleting products).
-(void)addCompany:(Company*)company;
-(void)editCompany:(Company*)company;
-(void)deleteCompany:(NSString *)companyId;

-(void)addProduct:(Product*)product toCompany:(Company*)company;
-(void)editProduct:(Product*)product;
-(void)deleteProduct:(Product*)product;

-(void)createCompaniesAndTheirProducts;


@end
