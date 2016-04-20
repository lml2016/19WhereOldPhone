//
//  RevaluationViewController.m
//  AiYou_Customer
//
//  Created by lml on 16/3/14.
//  Copyright © 2016年 lml. All rights reserved.
//

#import "RevaluationViewController.h"

@interface RevaluationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation RevaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"估值成功";
    _priceLabel.text = [NSString stringWithFormat:@"%ld元",self.price];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)anewRevaluation:(id)sender {
    
   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
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
