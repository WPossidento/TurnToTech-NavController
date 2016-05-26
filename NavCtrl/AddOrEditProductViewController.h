//
//  AddOrEditProductViewController.h
//  NavCtrl
//
//  Created by Macbook Pro on 4/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "Company.h"
#import "DataAccessObject.h"


@interface AddOrEditProductViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *companyNameDisplayLabel;
@property (retain, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *productNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *productURLTextField;
@property (retain, nonatomic) IBOutlet UITextField *productImageTextField;

@property (nonatomic) BOOL isEditing;

- (IBAction)SubmitButton:(id)sender;
- (IBAction)CancelButton:(id)sender;

@property (nonatomic, retain) NSString *productURL;

@property (nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) Company *company;
@property(nonatomic, retain) Product *product;
@property (nonatomic, retain) Company *productImage;

@property (nonatomic, retain) IBOutlet ProductViewController *productViewController;




@end
