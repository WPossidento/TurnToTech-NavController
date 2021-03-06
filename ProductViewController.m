//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *appleItems = @[@"iPad", @"iPod Touch",@"iPhone"];
    NSArray *samsungItems = @[@"Galaxy S7", @"Galaxy Note", @"Galaxy Tab"];
    NSArray *microsoftItems = @[@"Lumia 950", @"Lumia 950 XL", @"Lumia 650 Dual Sim"];
    NSArray *htcItems = @[@"HTC One A9", @"HTC One M9", @"HTC Desire 626"];
    
    self.appleProducts = [[NSMutableArray alloc] initWithArray:appleItems];
    self.samsungProducts = [[NSMutableArray alloc] initWithArray:samsungItems];
    self.microsoftProducts = [[NSMutableArray alloc] initWithArray:microsoftItems];
    self.htcProducts = [[NSMutableArray alloc] initWithArray:htcItems];
    
}

// viewWillAppear reloads every time a view loads whereas viewDidLoad loads only once.
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    NSArray *appleItems = @[@"iPad", @"iPod Touch",@"iPhone"];
//    NSArray *samsungItems = @[@"Galaxy S7", @"Galaxy Note", @"Galaxy Tab"];
//    NSArray *microsoftItems = @[@"Lumia 950", @"Lumia 950 XL", @"Lumia 650 Dual Sim"];
//    NSArray *htcItems = @[@"HTC One A9", @"HTC One M9", @"HTC Desire 626"];
//    
//    self.appleProducts = [[NSMutableArray alloc] initWithArray:appleItems];
//    self.samsungProducts = [[NSMutableArray alloc] initWithArray:samsungItems];
//    self.microsoftProducts = [[NSMutableArray alloc] initWithArray:microsoftItems];
//    self.htcProducts = [[NSMutableArray alloc] initWithArray:htcItems];
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
//        self.products = @[@"iPad", @"iPod Touch",@"iPhone"];
        self.products = _appleProducts;
    } else  if ([self.title isEqualToString:@"Samsung mobile devices"]) {
//        self.products = @[@"Galaxy S7", @"Galaxy Note", @"Galaxy Tab"];
        self.products = _samsungProducts;
    } else  if ([self.title isEqualToString:@"Microsoft mobile devices"]) {
//        self.products = @[@"Lumia 950", @"Lumia 950 XL", @"Lumia 650 Dual Sim"];
        self.products = _microsoftProducts;
    } else {
//        self.products = @[@"HTC One A9", @"HTC One M9", @"HTC Desire 626"];
        self.products = _htcProducts;
    }

    [self.tableView reloadData];
}

// Add delete functionality for the products:
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]
                         withRowAnimation:UITableViewRowAnimationTop];
    }
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
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    NSString *productName = [self.products objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = productName;

//    return cell;
    
    if ([self.title isEqualToString:@"Apple mobile devices"]) {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_Apple_48x48.jpg"]];
    } else  if ([self.title isEqualToString:@"Samsung mobile devices"]) {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_Samsung_48x48.jpg"]];
    } else  if ([self.title isEqualToString:@"Microsoft mobile devices"]) {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_Microsoft_48x48.jpg"]];
    } else {
            [[cell imageView] setImage: [UIImage imageNamed:@"logo_HTC_48x48.jpg"]];
    }
    
    return cell;
}

//// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *productName = [self.products objectAtIndex:[indexPath row]];
    
    self.webViewController =
    [[WebViewController alloc]
     initWithNibName:@"WebViewController" bundle:nil];
    
    if ([self.title isEqualToString:@"Apple mobile devices"] & (indexPath.row == 0)) {
        self.webViewController.title = productName; //@"iPad";
    } else if ([self.title isEqualToString:@"Apple mobile devices"] & (indexPath.row == 1)) {
        self.webViewController.title = productName; //@"iPod Touch";
    } else if ([self.title isEqualToString:@"Apple mobile devices"] & (indexPath.row == 2)) {
        self.webViewController.title = productName;//@"iPhone";
    } 
    
    if ([self.title isEqualToString:@"Samsung mobile devices"] & (indexPath.row == 0)) {
        self.webViewController.title = productName; //@"Galaxy S7";
    } else if ([self.title isEqualToString:@"Samsung mobile devices"] & (indexPath.row == 1)) {
        self.webViewController.title = productName; //@"Galaxy Note";
    } else if ([self.title isEqualToString:@"Samsung mobile devices"] & (indexPath.row == 2)) {
        self.webViewController.title = productName; //@"Galaxy Tab";
    }
    
    if ([self.title isEqualToString:@"Microsoft mobile devices"] & (indexPath.row == 0)) {
        self.webViewController.title = productName; //@"Lumia 950";
    } else if ([self.title isEqualToString:@"Microsoft mobile devices"] & (indexPath.row == 1)) {
        self.webViewController.title = productName; //@"Lumia 950 XL";
    } else if ([self.title isEqualToString:@"Microsoft mobile devices"] & (indexPath.row == 2)) {
        self.webViewController.title = productName; //@"Lumia 650 Dual Sim";
    }
    
    if ([self.title isEqualToString:@"HTC mobile devices"] & (indexPath.row == 0)) {
        self.webViewController.title = productName; //@"HTC One A9";
    } else if ([self.title isEqualToString:@"HTC mobile devices"] & (indexPath.row == 1)) {
        self.webViewController.title = productName; //@"HTC One M9";
    } else if ([self.title isEqualToString:@"HTC mobile devices"] & (indexPath.row == 2)) {
        self.webViewController.title = productName; //@"HTC Desire 626";
    }
    
    [self.navigationController
     pushViewController:self.webViewController
     animated:YES];

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
    NSString *stringToMove = self.products[fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.products removeObjectAtIndex:fromIndexPath.row]; // NOTE: fromIndexPath.row
    [self.products insertObject:stringToMove atIndex:toIndexPath.row]; // NOTE: toIndexPath.row
    
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
