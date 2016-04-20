//
//  ConfirmOrderCongroller.h
//  Aiyou
//
//  Created by Sniper on 16/2/29.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "BaseController.h"

@interface ConfirmOrderCongroller : BaseController
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (nonatomic,strong) OrderModel *orderModel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *identifyTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *VerifiTF;
@property (weak, nonatomic) IBOutlet UIButton *fetchVerifyButton;
@property (weak, nonatomic) IBOutlet UIView *inputViewBg;
@property (strong, nonatomic) NSString *productAttributeValues;
@property (strong, nonatomic) NSString *productAttributeValuesIds;

- (IBAction)fetchVerifyAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end
