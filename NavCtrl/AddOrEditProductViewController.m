//
//  AddOrEditProductViewController.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddOrEditProductViewController.h"
#import "ProductViewController.h"
#import "Product.h"
#import "AddOrEditCompanyViewController.h"
#import "DataAccessObject.h"

@interface AddOrEditProductViewController ()

@end

@implementation AddOrEditProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
//    if (self.product && self.productViewController.isEditing) {
    if (self.product && self.isEditing) {
        self.productNameTextField.text = self.product.productName;
        self.productURLTextField.text = self.product.productURL;
        self.productImageTextField.text = self.product.productImage;
    } else {
        self.productNameTextField.text = @"";
        self.productURLTextField.text = @"";
        self.productImageTextField.text = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_productNameTextField release];
    [_productURLTextField release];
    [_productImageTextField release];
    [super dealloc];
}

- (IBAction)SubmitButton:(id)sender {
    
//    if ([self.productViewController.tableView isEditing]) {
    if (self.isEditing) {
        _product.productName = _productNameTextField.text;
        _product.productURL = _productURLTextField.text;
        _product.productImage = _productImageTextField.text;
//        [self.productViewController.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"REVISED product data = %@, %@, %@", _product.productName, _product.productURL, _product.productImage);
        
    }
        
    else if (![_productNameTextField.text isEqualToString:@""] && ![_productURLTextField.text isEqualToString:@""]) {
        Product* newProduct = [[Product alloc] init];
        newProduct.companyName = [[NSString alloc] init];
        newProduct.productName = [[NSString alloc] init];
        newProduct.productURL = [[NSString alloc] init];
        newProduct.productImage = [[NSString alloc] init];
        newProduct.productName = self.productNameTextField.text;
        newProduct.productURL = self.productURLTextField.text;
        if (![_productImageTextField.text isEqualToString:@""]) {
            newProduct.productImage = _productImageTextField.text;
        } else {
//            newProduct.productImage = self.product.productImage;
//            newProduct.productImage = _product.productImage;
            newProduct.productImage = _company.companyLogoName;
        }

        [self.productViewController.products addObject:newProduct];
        [self.productViewController.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"New product data = %@, %@, %@", newProduct.productName, newProduct.productURL, newProduct.productImage);
    }
}

- (IBAction)CancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
