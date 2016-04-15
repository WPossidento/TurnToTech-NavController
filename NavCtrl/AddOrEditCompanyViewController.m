//
//  AddOrEditCompanyViewController.m
//  NavCtrl
//
//  Created by Macbook Pro on 4/13/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddOrEditCompanyViewController.h"
#import "CompanyViewController.h"
#import "Company.h"

@interface AddOrEditCompanyViewController ()

@end

@implementation AddOrEditCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

//  The DEALLOC method is called on an object when its retain count has reached zero. Retain counts are increased by one for each retain call, and reduced once for each release call. The autorelease schedules a future release call when the current NSAutoreleasePool is drained, typically at the end of an event cycle, but you can set up your own NSAutoreleasePools on memory intensive operations. (See the NSAutoreleasePool docs for details.)

//  An object’s dealloc method is the opposite of its init method. It’s called right before the object is destroyed, giving you a chance to clean up any internal objects. This method is called automatically by the runtime—you should never try to call dealloc yourself.

- (void)dealloc {
    NSLog(@"dealloc add edit controller");
    [_companyNameTextField release];
    [_companyTitleTextField release];
    [_companyLogoNameTextField release];
    [super dealloc];
    
}

- (IBAction)SubmitButton:(id)sender {
    if (![_companyNameTextField.text isEqualToString:@""] && ![_companyTitleTextField.text isEqualToString:@""]) {
        Company* newCompany = [[Company alloc] init];
        newCompany.companyName = [[NSString alloc] init];
        newCompany.companyTitle = [[NSString alloc] init];
        newCompany.companyLogoName = [[NSString alloc] init];
        newCompany.products = [[NSMutableArray alloc] init];
        newCompany.companyName = _companyNameTextField.text;
        newCompany.companyTitle = _companyTitleTextField.text;
        newCompany.companyLogoName = @"logo_default_48x48.jpg";
        [self.companyViewController.companies addObject:newCompany];
        [self.companyViewController.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"New company data = %@, %@, %@", newCompany.companyName, newCompany.companyTitle, newCompany.companyLogoName);
    }

}

- (IBAction)CancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

