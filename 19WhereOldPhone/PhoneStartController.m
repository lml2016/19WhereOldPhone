//
//  StartController.m
//  Aiyou
//
//  Created by Sniper on 16/3/1.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import "PhoneStartController.h"
#import "PhoneBrandController.h"
#import "PhoneSearchController.h"

@interface BaseController ()

@end

@implementation PhoneStartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"旧手机";
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startAction)];
    [self.startImageView addGestureRecognizer:ges];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startAction
{
    UIStoryboard *oldPhoneBoard = [UIStoryboard storyboardWithName:@"oldPhone" bundle:nil];
    PhoneBrandController *phoneBrandController =[oldPhoneBoard instantiateViewControllerWithIdentifier:@"PhoneBrandController"];
    [self.navigationController pushViewController:phoneBrandController animated:YES];

}

- (void) searchAction
{
    UIStoryboard *oldPhoneBoard = [UIStoryboard storyboardWithName:@"oldPhone" bundle:nil];
    PhoneSearchController *phoneSearchController =[oldPhoneBoard instantiateViewControllerWithIdentifier:@"PhoneSearchController"];
    [self.navigationController pushViewController:phoneSearchController animated:YES];
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
