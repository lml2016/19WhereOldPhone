//
//  BaseController.h
//  Wenba
//
//  Created by GL on 15/1/5.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppDelegate.h"
#import "NetUtils.h"
#import "UrlManager.h"
#import "SGCommon.h"
#import "SVProgressHUD.h"
#import "AppMacro.h"
#import "UtilsMacro.h"

#import "UIView+Utils.h"


@interface BaseController : UIViewController

@property (nonatomic,assign) float defaultTop;

@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;

- (void) initTapView;

@end
