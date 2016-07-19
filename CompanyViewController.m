
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DataAccessObject.h"
#import "AddOrEditCompanyViewController.h"
#import "NavControllerAppDelegate.h"
#import "ManagedCompany.h"

@interface CompanyViewController ()
@property (nonatomic, retain) IBOutlet AddOrEditCompanyViewController *addOrEditcompanyViewController;
@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        self.dao = [DataAccessObject sharedObject];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Undo button:
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoButtonClicked)];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem, undoButton];
    
    // Display an Add button in the navigation bar for this controller:
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonTapped:)]; // Colon after addButtonTapped indicates that the method takes an argument.
    self.navigationItem.leftBarButtonItem = addButton;
    
    self.addOrEditcompanyViewController = [[AddOrEditCompanyViewController alloc] init];
    
    self.title = @"Explore offerings from these companies";
    
    [self.tableView setAllowsSelectionDuringEditing:true]; // Permit selection of rows while in editing mode.
    self.dao = [DataAccessObject sharedObject];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.companies = [[DataAccessObject sharedObject] companies];
    [self getStockPrice];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Note NSURLSession is a successor to NSURLConnection. Get stock info (from Yahoo! Finance):
-(void)getStockPrice {
    
    NSMutableString *tempStr = [NSMutableString stringWithFormat:@"http://download.finance.yahoo.com/d/quotes.csv?s="];
    
    for (Company *company in self.companies) {
        [tempStr appendString:[NSMutableString stringWithFormat:@"%@+", company.companyStockSymbol]];
    }
    
    tempStr = (NSMutableString*)[tempStr stringByReplacingCharactersInRange:NSMakeRange([tempStr length]-1, 1) withString:@""];
    [tempStr appendString:[NSMutableString stringWithFormat:@"%@", @"&f=l1"]];
    
    self.stockURLString = [[NSMutableString alloc] initWithFormat:@"%@", tempStr];
    
    NSURL *url = [NSURL URLWithString:tempStr];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            // Check if any data returned.
        if (data != nil) {
            NSLog(@"\n\nThe string is: \n%@\n",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            NSMutableArray *companyStockPriceArray = (NSMutableArray*)[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] componentsSeparatedByString:@"\n"];
            [companyStockPriceArray removeLastObject];
            long n = [companyStockPriceArray count];
            for (int i = 0; i < n; i++) { // i = counter for looping through array elements
                NSLog(@"\n\ncompanyStockPriceArray = %@\n\n", companyStockPriceArray[i]);
                [self.companies[i] setCompanyStockPrice:companyStockPriceArray[i]];
            }
            // Get back to main thread to reload the table:
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });

            // Convert the returned data into a dictionary.
        } else if (data == nil) {
            NSLog(@"The data are nil");
        }
        
    }];
    
    [downloadTask resume];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
// #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
        return [self.companies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    // Configure the cell...
    Company *company = [self.companies objectAtIndex:indexPath.row];
    
// NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", myFloat];  @"%.2f"
    
    NSString *companyNameConcatCompanyStockPrice = [NSString stringWithFormat:@"%@- $%@/share", company.companyName, company.companyStockPrice];
    cell.textLabel.text = companyNameConcatCompanyStockPrice;
    cell.imageView.image = [UIImage imageNamed:company.companyLogoName];
    
    return cell;
    
 }

// Already exists in originally commented-out code given with assignment from Aditya:
//// Add row re-ordering functionality for the companies:
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES; // "return NO" will turn this function off.
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    NSString *stringToMove = self.companyList[sourceIndexPath.row];
//    [self.companyList removeObjectAtIndex:sourceIndexPath.row];
//    [self.companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
//}



// Add DELETE functionality for the companies:
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSString* compId = [[self.companies objectAtIndex:indexPath.row] companyId];
//  #this is not expecting a string, it's expecting an integer, is an index not a company id
        NSUInteger index = indexPath.row;
        
        [[DataAccessObject sharedObject] deleteCompany:index];
        [self.companies removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                         withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (IBAction)addButtonTapped:(id)sender {
    
    [self setEditing:NO];
    
    _addOrEditcompanyViewController.isEditing = self.isEditing;
    [self.navigationController pushViewController:self.addOrEditcompanyViewController animated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

// RE-ORDERING: Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// RE-ORDERING: Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Company *companyToMove = self.companies[fromIndexPath.row]; // NOTE: fromIndexPath.row
    [companyToMove retain];
    
    Company *managedCompanyToMove = self.dao.managedCompanies[fromIndexPath.row]; // NOTE: fromIndexPath.row
    [managedCompanyToMove retain];

    [self.dao.companies removeObjectAtIndex:fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.dao.managedCompanies removeObjectAtIndex:fromIndexPath.row]; // NOTE: fromIndexPath.row

    [self.dao.companies insertObject:companyToMove atIndex:toIndexPath.row]; // NOTE: toIndexPath.row
    [companyToMove release];
    
    [self.dao.managedCompanies insertObject:managedCompanyToMove atIndex:toIndexPath.row]; // NOTE: toIndexPath.row
    [managedCompanyToMove release];

    int kount = [self.dao.companies count];
    for (int i=0; i < kount; i++) {
        
        self.dao.companies[i].companyLocationInTable = [NSNumber numberWithInt:i];
        ManagedCompany *mc = self.dao.managedCompanies[i];
        [mc setCompanyLocationInTable:[NSNumber numberWithInt:i]];
        NSLog(@"MANAGED COMPANY NAME: %@ and POSITION: %@\n", mc.companyName, mc.companyLocationInTable);
    }
//    [self.dao.managedObjectContext save:nil]; // Moved to NavControllerAppDelegate.m

    [self.tableView reloadData];

}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company * company = [self.companies objectAtIndex:[indexPath row]];
    
    if ([self.tableView isEditing]) {
        // AVOID passing CompanyViewController to AddOrEditCompanyViewController by removing "self." as follows:
        self.addOrEditcompanyViewController.isEditing = self.isEditing;
        [self.navigationController pushViewController:self.addOrEditcompanyViewController animated:YES];
        self.addOrEditcompanyViewController.company = company;
        
    } else {
        
        self.productViewController.title = company.companyName;
        
        self.productViewController.company = company;
        
        [self.navigationController
         pushViewController: self.productViewController
         animated:YES];
    }
}

-(void) undoButtonClicked { // to undo re-arranging, editing, adding, or deleting of companies
    
    [self.dao undoLastAction];
    
    [self.tableView reloadData];
}

@end
