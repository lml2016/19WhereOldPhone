//
//  UploadPhonePicController.h
//  Aiyou
//
//  Created by Sniper on 16/3/1.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import "BaseController.h"

@interface UploadPhonePicController : BaseController

@property (weak, nonatomic) IBOutlet UIImageView *frontImg;
@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (nonatomic, assign) NSInteger orderId;

@end
