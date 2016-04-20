//
//  PhoneStartController.m
//  OldIPhoneModel
//
//  Created by lml on 16/4/20.
//  Copyright © 2016年 lml. All rights reserved.
//

#import "PhoneStartController.h"
#import "PhoneBrandController.h"

@interface PhoneStartController ()

@end

@implementation PhoneStartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"旧手机";
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAction)];
    [self.startImageView addGestureRecognizer:ges];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startAction
{
//    UIStoryboard *oldPhoneBoard = [UIStoryboard storyboardWithName:@"oldPhone" bundle:nil];
//    PhoneBrandController *phoneBrandController =[oldPhoneBoard instantiateViewControllerWithIdentifier:@"PhoneBrandController"];
    PhoneBrandController *phoneBrandController = [[PhoneBrandController alloc] initWithNibName:@"PhoneBrandController" bundle:nil];
    [self.navigationController pushViewController:phoneBrandController animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
