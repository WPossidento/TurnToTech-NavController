
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

#import "DataAccessObject.h"
#import "Company.h"
#import "Product.h"

@implementation DataAccessObject

+(DataAccessObject*) sharedObject {
    
    static DataAccessObject  *sharedDataAccessObject = nil;
    if(!sharedDataAccessObject) {
        sharedDataAccessObject = [[DataAccessObject alloc] init];
    }
    return sharedDataAccessObject;
}


// This method name is self-explanatory:
-(void)createCompaniesAndTheirProducts{
    
    // Apple products
    NSMutableArray *appleProductsArray = [[NSMutableArray alloc] init];
    [appleProductsArray addObject:[[Product alloc]initWithCompanyName:@"Apple" withProductName:@"iPad" withProductURL:@"http://www.apple.com/ipad-pro/" withProductImage:@"logo_Apple_48x48.jpg"]];
    [appleProductsArray addObject:[[Product alloc]initWithCompanyName:@"Apple" withProductName:@"iPod Touch" withProductURL:@"http://www.apple.com/ipod/compare-ipod-models/" withProductImage:@"logo_Apple_48x48.jpg"]];
    [appleProductsArray addObject:[[Product alloc]initWithCompanyName:@"Apple" withProductName:@"iPhone" withProductURL:@"http://www.apple.com/iphone/" withProductImage:@"logo_Apple_48x48.jpg"]];
    
    //self.appleProducts = appleProductsArray;
    
    
    // Samsung products
    NSMutableArray *samsungProductsArray = [[NSMutableArray alloc] init];
    [samsungProductsArray addObject:[[Product alloc]initWithCompanyName:@"Samsung" withProductName:@"Galaxy S7" withProductURL:@"http://www.samsung.com/us/mobile/cell-phones/SM-G935AZDAATT" withProductImage:@"logo_Samsung_48x48.jpg"]];
    [samsungProductsArray addObject:[[Product alloc]initWithCompanyName:@"Samsung" withProductName:@"Galaxy Note" withProductURL:@"http://www.samsung.com/us/mobile/cell-phones/SM-N920AZDEATT" withProductImage:@"logo_Samsung_48x48.jpg"]];
    [samsungProductsArray addObject:[[Product alloc]initWithCompanyName:@"Samsung" withProductName:@"Galaxy Tab" withProductURL:@"http://www.samsung.com/us/mobile/galaxy-tab/SM-T230NZWAXAR" withProductImage:@"logo_Samsung_48x48.jpg"]];
    
    //self.samsungProducts = samsungProductsArray;
    
    
    // Microsoft products
    NSMutableArray *microsoftProductsArray = [[NSMutableArray alloc] init];
    [microsoftProductsArray addObject:[[Product alloc]initWithCompanyName:@"Microsoft" withProductName:@"Lumia 950" withProductURL:@"http://www.microsoftstore.com/store/msusa/en_US/pdp/ATT--Microsoft-Lumia-950/productID.330607700" withProductImage:@"logo_Microsoft_48x48.jpg"]];
    [microsoftProductsArray addObject:[[Product alloc]initWithCompanyName:@"Microsoft" withProductName:@"Lumia 950 XL" withProductURL:@"http://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950-XL--Unlocked/productID.326602300" withProductImage:@"logo_Microsoft_48x48.jpg"]];
    [microsoftProductsArray addObject:[[Product alloc]initWithCompanyName:@"Microsoft" withProductName:@"Lumia 650 Dual Sim" withProductURL:@"http://www.microsoftstore.com/store/msusa/en_US/pdp/productID.334960800?icid=US_Lumia__lumia650_031116" withProductImage:@"logo_Microsoft_48x48.jpg"]];
    
    //self.microsoftProducts = microsoftProductsArray;
    
    
    // HTC products
    NSMutableArray *htcProductsArray = [[NSMutableArray alloc] init];
    [htcProductsArray addObject:[[Product alloc]initWithCompanyName:@"HTC" withProductName:@"HTC One A9" withProductURL:@"https://www.htc.com/us/smartphones/htc-one-a9/" withProductImage:@"logo_HTC_48x48.jpg"]];
    [htcProductsArray addObject:[[Product alloc]initWithCompanyName:@"HTC" withProductName:@"HTC One M9" withProductURL:@"https://www.htc.com/us/smartphones/htc-one-m9/"  withProductImage:@"logo_HTC_48x48.jpg"]];
    [htcProductsArray addObject:[[Product alloc]initWithCompanyName:@"HTC" withProductName:@"HTC Desire 626" withProductURL:@"https://www.htc.com/us/smartphones/htc-desire-626/" withProductImage:@"logo_HTC_48x48.jpg"]];
    
    //self.htcProducts = htcProductsArray;
    
    
    NSMutableArray *companiesLocal = [[NSMutableArray alloc] init];
    
    [companiesLocal addObject:[[Company alloc ]initWithCompanyName:@"Apple" withCompanyTitle:@"Apple mobile devices" withCompanyLogoName:@"logo_Apple_48x48.jpg" withProducts:appleProductsArray]];
    
    [companiesLocal addObject:[[Company alloc]initWithCompanyName:@"Samsung" withCompanyTitle:@"Samsung mobile devices" withCompanyLogoName:@"logo_Samsung_48x48.jpg" withProducts:samsungProductsArray]];
    
    [companiesLocal addObject:[[Company alloc] initWithCompanyName:@"Microsoft" withCompanyTitle:@"Microsoft mobile devices" withCompanyLogoName:@"logo_Microsoft_48x48.jpg" withProducts:microsoftProductsArray]];
    
    [companiesLocal addObject:[[Company alloc] initWithCompanyName:@"HTC" withCompanyTitle:@"HTC mobile devices" withCompanyLogoName:@"logo_HTC_48x48.jpg" withProducts:htcProductsArray]];
    
    self.companies = companiesLocal;

}

@end



