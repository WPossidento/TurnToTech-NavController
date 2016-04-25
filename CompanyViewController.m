//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DataAccessObject.h"
#import "AddOrEditCompanyViewController.h"

@interface CompanyViewController ()
@property (nonatomic, retain) IBOutlet AddOrEditCompanyViewController *addOrEditcompanyViewController;
@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // Display an Add button in the navigation bar for this controller:
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonTapped:)]; // Colon after addButtonTapped indicates that the method takes an argument.
    self.navigationItem.leftBarButtonItem = addButton;
    
    self.addOrEditcompanyViewController = [[AddOrEditCompanyViewController alloc] init];
   // self.addOrEditcompanyViewController.companyViewController = self; // method chaining aka relationship chaining

//  What is Data Access Object?
    
//  In computer software, a data access object (DAO) is an object that provides an abstract interface to some type of database or other persistence mechanism. By mapping application calls to the persistence layer, the DAO provide some specific data operations without exposing details of the database.
    
 // Create a dataaccess object variable.
    [[DataAccessObject sharedObject] createCompaniesAndTheirProducts]; // Call the createCompaniesAndTheirProducts method and assign the results to dao - the new variable.
    self.companies = [[DataAccessObject sharedObject] companies] ; // Assign the companies in dao to companies on self - the company view controller.
    
    self.title = @"Mobile device makers";
    
    [self.tableView setAllowsSelectionDuringEditing:true]; // Permit selection of rows while in editing mode.

}

-(void)viewWillAppear:(BOOL)animated {
    self.companies = [[DataAccessObject sharedObject] companies];
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
    
//    [cell setEditingAccessoryType:UITableViewCellAccessoryDetailButton]; for abandoned idea of using Info button = Accessory Detail Button for updating companies.
    
    // Configure the cell...
    Company *company = [self.companies objectAtIndex:indexPath.row];
    
    cell.textLabel.text = company.companyName;
    cell.imageView.image = [UIImage imageNamed:company.companyLogoName];
    
    return cell;

//    cell.textLabel.text = [[self.companies objectAtIndex:[indexPath row]] companyName:];
    
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

// For abandoned idea of using Info button = Accessory Detail Button for updating companies:
//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath {
//    
//    NSLog(@"If this displays - good!");
//    
//}

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
    
    NSString *stringToMove = self.companies[fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.companies removeObjectAtIndex:fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.companies insertObject:stringToMove atIndex:toIndexPath.row]; // NOTE: toIndexPath.row

}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company *company = [self.companies objectAtIndex:[indexPath row]];
    
    if ([self.tableView isEditing]) {
//            [self.navigationController pushViewController:self.addOrEditcompanyViewController animated:YES];
        // AVOID passing CompanyViewController to AddOrEditCompanyViewController by removing "self." as follows:
        _addOrEditcompanyViewController.isEditing = self.isEditing;
        [self.navigationController pushViewController:_addOrEditcompanyViewController animated:YES];
        _addOrEditcompanyViewController.company = company;
        
    } else {
    
    _productViewController.title = company.companyTitle;
    
    _productViewController.products = company.products;
    
    _productViewController.company = company;
    
    [self.navigationController
        pushViewController: self.productViewController
        animated:YES];
    }
}

@end
