//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "CompanyViewController.h"
#import "Company.h"
#import "Product.h"
#import "DataAccessObject.h"
#import "AddOrEditProductViewController.h"
#import "AddOrEditCompanyViewController.h"

@interface ProductViewController ()

@property (nonatomic, retain) IBOutlet AddOrEditProductViewController *addOrEditProductViewController;
@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;


@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// viewDidLoad loads once whereas viewWillAppear reloads every time a view loads.
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Display an Add button in the navigation bar for this controller:
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonTapped:)]; // Colon after addButtonTapped indicates that the method takes an argument.
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem, addButton];
    
    self.addOrEditProductViewController = [[AddOrEditProductViewController alloc] init];
    
    self.addOrEditProductViewController.productViewController = self; // method chaining aka relationship chaining
    [self.tableView setAllowsSelectionDuringEditing:true]; // Permit selection of rows while in editing mode.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // Create a dataaccess object variable.
    [[DataAccessObject sharedObject] createCompaniesAndTheirProducts];
    
}

// viewWillAppear reloads every time a view loads whereas viewDidLoad loads only once.
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.addOrEditProductViewController.company = self.company;

    //self.companies = [[DataAccessObject sharedObject] companies];
    //self.products = [[DataAccessObject sharedObject] products];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.company.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    Product *product = [self.company.products objectAtIndex:indexPath.row];
    cell.textLabel.text = product.productName;
    cell.imageView.image = [UIImage imageNamed:product.productImage];

    return cell;
}

//// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *productName = [self.products objectAtIndex:[indexPath row]];
    
     Product *product = [self.company.products objectAtIndex:[indexPath row]];
    
    if ([self.tableView isEditing]) {
        self.addOrEditProductViewController.isEditing = self.isEditing;
        [self.navigationController pushViewController:self.addOrEditProductViewController animated:YES];
        self.addOrEditProductViewController.product = product;
    }
    else {
        
        self.webViewController =
        [[WebViewController alloc]
         initWithNibName:@"WebViewController" bundle:nil];
        self.webViewController.productURL = [self.company.products[indexPath.row] productURL];
        
        [self.navigationController
         pushViewController:self.webViewController
         animated:YES];
        
    }
    

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *stringToMove = self.company.products[fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.company.products removeObjectAtIndex:fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.company.products insertObject:stringToMove atIndex:toIndexPath.row]; // NOTE: toIndexPath.row
    
}

// Add delete functionality for the products:
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Product* prodId = [self.company.products objectAtIndex:indexPath.row];
        
        [[DataAccessObject sharedObject] deleteProduct:prodId];
        
        [self.company.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                         withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (IBAction)addButtonTapped:(id)sender {
    
    [self setEditing:NO];
    self.addOrEditProductViewController.isEditing = self.isEditing;
    self.addOrEditProductViewController.company = self.company;
    [self.navigationController pushViewController:self.addOrEditProductViewController animated:YES];
    
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
