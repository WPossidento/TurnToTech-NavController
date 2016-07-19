
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
    [super viewWillAppear:animated];
//    if (self.product && self.productViewController.isEditing) {
    if (self.company.products && self.isEditing) {
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
        _product.company_id = [NSString stringWithFormat:@"%d", _company.companyId];
        _product.productName = _productNameTextField.text;
        _product.productURL = _productURLTextField.text;
        _product.productImage = _productImageTextField.text;
        [self.productViewController.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"REVISED product data = %@, %@, %@", _product.productName, _product.productURL, _product.productImage);
        
//       [[DataAccessObject sharedObject] editCompany:_company];
//       [[DataAccessObject sharedObject] modifyProduct:_product];
        [[DataAccessObject sharedObject] modifyProduct:self.productIndex forCompany:_company forProduct:_product];
    }
        
    else if (![_productNameTextField.text isEqualToString:@""] && ![_productURLTextField.text isEqualToString:@""]) {
     
        if ([_productImageTextField.text isEqualToString:@""]) {
             _productImageTextField.text = _company.companyLogoName;
        }
        
        //FIXME: use initializer!
        
        [[DataAccessObject sharedObject] addProduct:self.productNameTextField.text productURL:self.productURLTextField.text productImage:self.productImageTextField.text forCompany:self.company];

//        [product release];
        
        [self.productViewController.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (IBAction)CancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
