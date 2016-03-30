//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"

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
    
    
<<<<<<< HEAD
    self.companyList = @[@"Apple mobile devices",@"Samsung mobile devices",@"Microsoft mobile devices",@"HTC mobile devices"];
=======
    self.companyList = @[@"Apple mobile devices",@"Samsung mobile devices"];
>>>>>>> c6d5c0ecd0ea83e7b9e57e59e86a24aa7151b753
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
<<<<<<< HEAD
// #warning Potentially incomplete method implementation.
=======
#warning Potentially incomplete method implementation.
>>>>>>> c6d5c0ecd0ea83e7b9e57e59e86a24aa7151b753
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
<<<<<<< HEAD
// #warning Incomplete method implementation.
=======
#warning Incomplete method implementation.
>>>>>>> c6d5c0ecd0ea83e7b9e57e59e86a24aa7151b753
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
<<<<<<< HEAD
    NSString *companyName = [self.companyList objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = companyName;
    
    if ([companyName isEqualToString:@"Apple mobile devices"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"logo_Apple_48x48.jpg"]];
    } else  if ([companyName isEqualToString:@"Samsung mobile devices"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"logo_Samsung_48x48.jpg"]];
    } else  if ([companyName isEqualToString:@"Microsoft mobile devices"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"logo_Microsoft_48x48.jpg"]];
    } else {
        [[cell imageView] setImage: [UIImage imageNamed:@"logo_HTC_48x48.jpg"]];
    }

=======
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    
>>>>>>> c6d5c0ecd0ea83e7b9e57e59e86a24aa7151b753
    return cell;
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

<<<<<<< HEAD
    if (indexPath.row == 0){
        self.productViewController.title = @"Apple mobile devices";
    } else if (indexPath.row == 1){
        self.productViewController.title = @"Samsung mobile devices";
    } else if (indexPath.row == 2){
        self.productViewController.title = @"Microsoft mobile devices";
    } else {
        self.productViewController.title = @"HTC mobile devices";
=======

    if (indexPath.row == 0){
        self.productViewController.title = @"Apple mobile devices";
    } else {
        self.productViewController.title = @"Samsung mobile devices";
>>>>>>> c6d5c0ecd0ea83e7b9e57e59e86a24aa7151b753
    }
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}
 


@end
