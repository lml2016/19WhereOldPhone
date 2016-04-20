//
//  UploadPhonePicController.m
//  Aiyou
//
//  Created by Sniper on 16/3/1.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import "UploadPhonePicController.h"
#import "PECropViewController.h"
#import "PhoneUrlManager.h"
#import "OrderSuccessController.h"

@interface UploadPhonePicController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) CameraType camertType;
@property (weak, nonatomic) IBOutlet UIImage *frontPostImg;
@property (weak, nonatomic) IBOutlet UIImage *backPostImg;


@end

@implementation UploadPhonePicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传照片";
    UITapGestureRecognizer *gesFront = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontAction)];
    [self.frontImg addGestureRecognizer:gesFront];
    UITapGestureRecognizer *gesBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [self.backImg addGestureRecognizer:gesBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) frontAction
{
    [self imageAction];
    self.camertType = Front;
}

- (void)backAction
{
    [self imageAction];
    self.camertType = Back;
}


- (void)imageAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"从相册中选取", nil), nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"拍照", nil)];
    }
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"取消", nil)];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [actionSheet showInView:self.view];
        //        [actionSheet showFromBarButtonItem:self.cameraButton animated:YES];
    } else {
        [actionSheet showFromToolbar:self.navigationController.toolbar];
    }
}


- (IBAction)submitAction:(id)sender
{
    if (!self.frontPostImg || !self.backPostImg) {
        [SVProgressHUD showErrorWithStatus:@"请先选择照片"];
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInteger:self.orderId] forKey:@"orderid"];
    [dic setObject:[self scaleImg:self.frontPostImg] forKey:@"pic0"];
    [dic setObject:[self scaleImg:self.backPostImg] forKey:@"pic1"];
    
    NSURL *url = [NSURL URLWithString:URL_PHONE_COMMIT_PIC];
    [SVProgressHUD showWithStatus:@"正在提交..."];
    [NetUtils doPostMutipart:dic withUrl:url withResultBlock:^(BaseModel *resultModel) {
        if (resultModel) {
            if (resultModel.status.success) {
                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                OrderSuccessController *controller = [appDelegate.phoneStoryBoard instantiateViewControllerWithIdentifier:@"OrderSuccessController"];
                [self.navigationController pushViewController:controller animated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:resultModel.status.message duration:1];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"提交失败" duration:1];
        }
    }];
}

- (UIImage *) scaleImg : (UIImage *) image
{
    int w = image.size.width;
    if (w > 520) {
        w = 520;
    }
    return [SGCommon scaleToSize:image size:CGSizeMake(w, image.size.height * w / image.size.width)];
}
#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 || buttonIndex == 1) {
        [self showCropView:buttonIndex];
    }
}

- (void)showCropView : (int) type
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.photoType = type;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark -

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    if (self.camertType == Front) {
        self.frontImg.contentMode = UIViewContentModeScaleAspectFit;
        self.frontImg.alpha = 1;
        self.frontImg.image = croppedImage;
        self.frontPostImg = croppedImage;
    }else{
        self.backImg.contentMode = UIViewContentModeScaleAspectFit;
        self.backImg.alpha = 1;
        self.backImg.image = croppedImage;
        self.backPostImg =croppedImage;
    }
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}




@end
