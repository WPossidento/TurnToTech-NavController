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

@interface CompanyViewController ()

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
    
    
    /* I could delete this commented-out section but I'll keep it to show how much code was transferred to the DataAccessObject class:
    
    // Apple products
    NSMutableArray *appleProductsArray = [[NSMutableArray alloc] init];
    [appleProductsArray addObject:[[Product alloc]initWithCompanyName:@"Apple" withProductName:@"iPad" withProductURL:@"http://www.apple.com/ipad-pro/"]];
    [appleProductsArray addObject:[[Product alloc]initWithCompanyName:@"Apple" withProductName:@"iPod Touch" withProductURL:@"http://www.apple.com/ipod/compare-ipod-models/"]];
    [appleProductsArray addObject:[[Product alloc]initWithCompanyName:@"Apple" withProductName:@"iPhone" withProductURL:@"http://www.apple.com/iphone/"]];
    
    // Samsung products
    NSMutableArray *samsungProductsArray = [[NSMutableArray alloc] init];
    [samsungProductsArray addObject:[[Product alloc]initWithCompanyName:@"Samsung" withProductName:@"Galaxy S7" withProductURL:@"http://www.samsung.com/us/mobile/cell-phones/SM-G935AZDAATT"]];
    [samsungProductsArray addObject:[[Product alloc]initWithCompanyName:@"Samsung" withProductName:@"Galaxy Note" withProductURL:@"http://www.samsung.com/us/mobile/cell-phones/SM-N920AZDEATT"]];
    [samsungProductsArray addObject:[[Product alloc]initWithCompanyName:@"Samsung" withProductName:@"Galaxy Tab" withProductURL:@"http://www.samsung.com/us/mobile/galaxy-tab/SM-T230NZWAXAR"]];
    
    // Microsoft products
    NSMutableArray *microsoftProductsArray = [[NSMutableArray alloc] init];
    [microsoftProductsArray addObject:[[Product alloc]initWithCompanyName:@"Microsoft" withProductName:@"Lumia 950" withProductURL:@"http://www.microsoftstore.com/store/msusa/en_US/pdp/ATT--Microsoft-Lumia-950/productID.330607700"]];
    [microsoftProductsArray addObject:[[Product alloc]initWithCompanyName:@"Microsoft" withProductName:@"Lumia 950 XL" withProductURL:@"http://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950-XL--Unlocked/productID.326602300"]];
    [microsoftProductsArray addObject:[[Product alloc]initWithCompanyName:@"Microsoft" withProductName:@"Lumia 650 Dual Sim" withProductURL:@"http://www.microsoftstore.com/store/msusa/en_US/pdp/productID.334960800?icid=US_Lumia__lumia650_031116"]];
    
    // HTC products
    NSMutableArray *htcProductsArray = [[NSMutableArray alloc] init];
    [htcProductsArray addObject:[[Product alloc]initWithCompanyName:@"HTC" withProductName:@"HTC One A9" withProductURL:@"https://www.htc.com/us/smartphones/htc-one-a9/"]];
    [htcProductsArray addObject:[[Product alloc]initWithCompanyName:@"HTC" withProductName:@"HTC One M9" withProductURL:@"https://www.htc.com/us/smartphones/htc-one-m9/"]];
    [htcProductsArray addObject:[[Product alloc]initWithCompanyName:@"HTC" withProductName:@"HTC Desire 626" withProductURL:@"https://www.htc.com/us/smartphones/htc-desire-626/"]];
    
    
    
    NSMutableArray *companiesLocal = [[NSMutableArray alloc] init];
    
    [companiesLocal addObject:[[Company alloc ]initWithCompanyName:@"Apple" withCompanyTitle:@"Apple mobile devices" withCompanyLogoName:@"logo_Apple_48x48.jpg" withProducts:appleProductsArray]];
    
    [companiesLocal addObject:[[Company alloc]initWithCompanyName:@"Samsung" withCompanyTitle:@"Samsung mobile devices" withCompanyLogoName:@"logo_Samsung_48x48.jpg" withProducts:samsungProductsArray]];
    
    [companiesLocal addObject:[[Company alloc] initWithCompanyName:@"Microsoft" withCompanyTitle:@"Microsoft mobile devices" withCompanyLogoName:@"logo_Microsoft_48x48.jpg" withProducts:microsoftProductsArray]];
    
    [companiesLocal addObject:[[Company alloc] initWithCompanyName:@"HTC" withCompanyTitle:@"HTC mobile devices" withCompanyLogoName:@"logo_HTC_48x48.jpg" withProducts:htcProductsArray]];
    
    self.companies = companiesLocal;
     
     */
    
    /*
********************************************************
     */
    
//  What is Data Access Object?
    
//  In computer software, a data access object (DAO) is an object that provides an abstract interface to some type of database or other persistence mechanism. By mapping application calls to the persistence layer, the DAO provide some specific data operations without exposing details of the database.
    
    DataAccessObject *dao = [[DataAccessObject alloc]init]; // Create a dataaccess object variable.
    [dao createCompaniesAndTheirProducts]; // Call the createCompaniesAndTheirProducts method and assign the results to dao - the new variable.
    self.companies = dao.companies; // Assign the companies in dao to companies on self - the company view controller.
    
    self.title = @"Mobile device makers";

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
    
    // Configure the cell...
    NSString *companyName = [[self.companies objectAtIndex:[indexPath row]] companyName];
    
    cell.textLabel.text = companyName;
    
    if (!companyName) {
    }
    else {
        if ([companyName isEqualToString:@"Apple"]) {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_Apple_48x48.jpg"]];
        } else  if ([companyName isEqualToString:@"Samsung"]) {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_Samsung_48x48.jpg"]];
        } else  if ([companyName isEqualToString:@"Microsoft"]) {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_Microsoft_48x48.jpg"]];
        } else if ([companyName isEqualToString:@"HTC"]) {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_HTC_48x48.jpg"]];
        } else { // Use generic logo for added companies:
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_default_48x48.jpg"]];
        }
    }

//    cell.textLabel.text = [[self.companies objectAtIndex:[indexPath row]] companyName:];
    
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
        [self.companies removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
        withRowAnimation:UITableViewRowAnimationTop];
    }
}


- (IBAction)addButtonTapped:(id)sender {
    
    UIAlertController *popUp = [UIAlertController alertControllerWithTitle:@"Add a company" message:@"Please enter a company to add." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { // "^" indicates a block
        Company* newCompany = [[Company alloc] init];
        
        if (![popUp.textFields[0].text isEqualToString: @""]) {

            newCompany.companyName = popUp.textFields[0].text;
        
            [self.companies addObject:newCompany]; // Add new company to array of companies.
        
            NSLog(@"The new company is %@\n\n", newCompany.companyName);
        
            NSLog(@"Submitted\n\n");
            
            dispatch_async(dispatch_get_main_queue(), ^{ // Must wrap reload to get it to affect main queue because it otherwise would be in a block on its own thread
                // do work here
                [self.tableView reloadData];
        });
        
        }
    }];
    
    [popUp addAction:defaultAction];
    
    [popUp addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Input data...";
    }];
    
    // Add cancel button:
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [popUp dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [popUp addAction:cancel];
    // End add cancel button.
    
    [self presentViewController:popUp animated:YES completion:nil];

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

// RE-ORDERING: Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// RE-ORDERING: Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
//    NSString *stringToMove = self.companyList[fromIndexPath.row]; // NOTE: fromIndexPath.row
//        [self.companyList removeObjectAtIndex:fromIndexPath.row]; // NOTE: fromIndexPath.row
//    [self.companyList insertObject:stringToMove atIndex:toIndexPath.row]; // NOTE: toIndexPath.row
    
    NSString *stringToMove = self.companies[fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.companies removeObjectAtIndex:fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.companies insertObject:stringToMove atIndex:toIndexPath.row]; // NOTE: toIndexPath.row

}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSString *companyName = [self.companyList objectAtIndex:[indexPath row]];
    Company *company = [self.companies objectAtIndex:[indexPath row]];
    
    self.productViewController.title = company.companyTitle;
    self.productViewController.products = company.products;

    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];

}

@end
