//
//  ConfirmOrderCongroller.m
//  Aiyou
//
//  Created by Sniper on 16/2/29.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import "ConfirmOrderCongroller.h"
#import "UploadPhonePicController.h"
#import "PhoneUrlManager.h"

@interface ConfirmOrderCongroller ()<UITextFieldDelegate>
{
    NSTimer* timer;
    int currentAlarmTime;
}

@property (assign,nonatomic) BOOL shouldMoveView;
@end

@implementation ConfirmOrderCongroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认信息";
    self.shouldMoveView = YES;
    [self initTapView];
    [self setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupView
{
    self.brandLabel.text = self.orderModel.phoneModel.phoneBrand.brand_name;
    self.typeLabel.text = self.orderModel.phoneModel.product_name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.orderModel.price];
    
    self.nameTF.delegate = self;
    self.identifyTF.delegate = self;
    self.phoneNumTF.delegate = self;
    self.VerifiTF.delegate = self;
    
}

- (IBAction)submitAction:(id)sender {

    if (!self.nameTF.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    
    if (!self.identifyTF.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    
 

    if (!self.phoneNumTF.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码" duration:TOAST_SHORT];
        return;
    }
    if(![SGCommon isValidateMobile:self.phoneNumTF.text]){
        [SVProgressHUD showErrorWithStatus:@"手机号码格式错误" duration:TOAST_SHORT];
        return;
    }
    
    if (!self.VerifiTF.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (self.VerifiTF.text.length) {
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];


        
        [dic setObject:self.phoneNumTF.text forKey:@"userPhoneNumber"];
        [dic setObject:self.nameTF.text forKey:@"userName"];
        [dic setObject:self.identifyTF.text forKey:@"identityCard"];
        
        [dic setObject:[NSNumber numberWithInteger:self.orderModel.phoneModel.product_id] forKey:@"productId"];
        [dic setObject:@"12" forKey:@"channelId"];
        [dic setObject:[NSString stringWithFormat:@"%d",self.orderModel.price] forKey:@"orderRoughTotal"];
        [dic setObject:self.productAttributeValuesIds forKey:@"productAttributeValueIds"];
        [dic setObject:self.productAttributeValues forKey:@"productAttributeValues"];
        [dic setObject:self.orderModel.phoneModel.product_name forKey:@"productName"];
        [dic setObject:@"321" forKey:@"staffId"];
        [dic setObject:@"staffnametemp" forKey:@"staffName"];
        [dic setObject:@"1234" forKey:@"staffCode"];
        
//        [dic setObject:appDelegate.user.uid forKey:@"staffId"];
//        [dic setObject:appDelegate.user.staff_name forKey:@"staffName"];
//        [dic setObject:appDelegate.user.staff_code forKey:@"staffCode"];
        
        [dic setObject:self.VerifiTF.text forKey:@"verifyCheckCode"];
        [dic setObject:@"" forKey:@"storeCode"];
        [dic setObject:@"" forKey:@"storeName"];
        [dic setObject:@"" forKey:@"companyName"];
        [dic setObject:@"" forKey:@"address"];
        [dic setObject:@"" forKey:@"imei"];
        [dic setObject:@"" forKey:@"acquirerId"];
        
//        [self fetchAccessToken:dic];
        [SVProgressHUD showWithStatus:@"请稍候..."];
        [NetUtils doPost:dic withUrl:[NSURL URLWithString:URL_PHONE_COMMIT_ORDER] withResultBlock:^(BaseModel *resultModel) {
            [SVProgressHUD dismiss];
            if (resultModel) {
                if ( resultModel.status.success) {
                    [self filterTime];
                    [SVProgressHUD showSuccessWithStatus:@"发送成功" duration:TOAST_SHORT];
                    UploadPhonePicController *controller = [appDelegate.phoneStoryBoard instantiateViewControllerWithIdentifier:@"UploadPhonePicController"];
                    controller.orderId = [[resultModel.data objectForKey:@"order_id"] integerValue];
                    [self.navigationController pushViewController:controller animated:YES];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:resultModel.status.message duration:TOAST_SHORT];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"发送失败" duration:TOAST_SHORT];
            }
            
        }];
        
    }

}



/**
 * 发送验证码
 **/
- (IBAction)fetchVerifyAction:(id)sender {

    if (!self.phoneNumTF.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码" duration:TOAST_SHORT];
        return;
    }
    if(![SGCommon isValidateMobile:self.phoneNumTF.text]){
        [SVProgressHUD showErrorWithStatus:@"手机号码格式错误" duration:TOAST_SHORT];
        return;
    }

    NSURL *url = [NSURL URLWithString:URL_PHONE_SEND_SMS];
    [SVProgressHUD showWithStatus:@"请稍候..."];
    
    [NetUtils doPost:@{@"userPhoneNumber":self.phoneNumTF.text} withUrl:url withResultBlock:^(BaseModel *resultModel) {
        [SVProgressHUD dismiss];
        if (resultModel) {
            if ( resultModel.status.success) {
                [self filterTime];
                [SVProgressHUD showSuccessWithStatus:@"发送成功" duration:TOAST_SHORT];
            }else{
                [SVProgressHUD showErrorWithStatus:resultModel.status.message duration:TOAST_SHORT];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"发送失败" duration:TOAST_SHORT];
        }
    }];
    
    
    
}


- (void) filterTime
{
    [self alarmReset];
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateClockAlarm) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void) updateClockAlarm
{
    currentAlarmTime = currentAlarmTime - 1;
    if (currentAlarmTime <= 0) {
        [self timerEnd];
    }else{
        NSString *alarmString = [NSString stringWithFormat:@"%d",currentAlarmTime];
        [self.fetchVerifyButton setTitle:alarmString forState:UIControlStateNormal];
        [self.fetchVerifyButton setTitle:alarmString forState:UIControlStateHighlighted];
    }
}


- (void) alarmReset
{
    self.fetchVerifyButton.enabled = NO;
    self.fetchVerifyButton.backgroundColor = [UIColor grayColor];
    if (timer){
        [timer invalidate];
        timer = nil;
    }
    currentAlarmTime = 60;
    [self.fetchVerifyButton setTitle:[NSString stringWithFormat:@"%d",60] forState:UIControlStateNormal];
}

- (void) timerEnd
{
    if (timer){
        [timer invalidate];
        timer = nil;
        self.fetchVerifyButton.enabled = YES;
        self.fetchVerifyButton.backgroundColor = UIColorFromRGB(NAV_BG_COLOR);
        [self.fetchVerifyButton setTitle:@"获取" forState:UIControlStateNormal];
        [self.fetchVerifyButton setTitle:@"获取" forState:UIControlStateHighlighted];
    }
}

#pragma mark - access token
 - (void) fetchAccessToken : (NSMutableDictionary *)dic
{
    [SVProgressHUD showWithStatus:@"请稍候..."];
    NSString * urlString = URL_PHONE_COMMIT_ORDER;
    [NetUtils doGet2:[NSURL URLWithString:urlString] withResultBlock:^(NSString *result) {
        if (result) {
            NSError *error;
            NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            NSString *access_token = [jsonDic objectForKey:@"access_token"];
            if (access_token) {
                [dic setObject:access_token forKey:@"staffToken"];
                [self commitOrder:dic];
            }else{
              [SVProgressHUD showErrorWithStatus:@"操作失败" duration:TOAST_SHORT];
            }

        }else{
            [SVProgressHUD showErrorWithStatus:@"操作失败" duration:TOAST_SHORT];
        }
     

    }];
}

- (void) commitOrder : (NSDictionary *)dic
{

    [NetUtils doPost:dic withUrl:[NSURL URLWithString:URL_PHONE_COMMIT_ORDER] withResultBlock:^(BaseModel *resultModel) {
        [SVProgressHUD dismiss];
        if (resultModel) {
            if ( resultModel.status.success) {
                [self filterTime];
                [SVProgressHUD showSuccessWithStatus:@"发送成功" duration:TOAST_SHORT];
                UploadPhonePicController *controller = [appDelegate.phoneStoryBoard instantiateViewControllerWithIdentifier:@"UploadPhonePicController"];
                controller.orderId = [[resultModel.data objectForKey:@"order_id"] integerValue];
                [self.navigationController pushViewController:controller animated:YES];
                
            }else{
                [SVProgressHUD showErrorWithStatus:resultModel.status.message duration:TOAST_SHORT];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"操作失败" duration:TOAST_SHORT];
        }
        
    }];

}

#pragma mark - 处理键盘
-(void)backgroundTap:(id)sender
{
    [self.nameTF resignFirstResponder];
    [self.identifyTF resignFirstResponder];
    [self.phoneNumTF resignFirstResponder];
    [self.VerifiTF resignFirstResponder];
    
}



- (void) moveInputBarWithKeyboardHeight : (float )height withDuration : (float) duration
{
    [UIView animateWithDuration:duration animations:^{
        if (self.shouldMoveView) {
            if (height == 0) {
                 self.view.top = height * -1 + self.defaultTop ;
            }else{
                self.view.top = height * -1 + self.defaultTop + 130;
            }
           
        }
    }];
}




@end
