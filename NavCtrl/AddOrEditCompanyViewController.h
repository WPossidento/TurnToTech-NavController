//
//  AddOrEditCompanyViewController.h
//  NavCtrl
//
//  Created by Macbook Pro on 4/13/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CompanyViewController.h"
#import "Company.h"

@interface AddOrEditCompanyViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyTitleTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyLogoNameTextField;

@property (nonatomic) BOOL isEditing;


- (IBAction)SubmitButton:(id)sender;
- (IBAction)CancelButton:(id)sender;



//@property (nonatomic, retain) IBOutlet CompanyViewController *companyViewController;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) NSString *companyLogoName;



@end
