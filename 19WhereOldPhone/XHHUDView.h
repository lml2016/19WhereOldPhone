//
//  XHHUDView.h
//  Sniperbrowser
//
//  Created by guo liang on 13-12-17.
//  Copyright (c) 2013年 Simon Peter Grätzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHShockHUDHeader.h"

@interface XHHUDView : UIView
@property (nonatomic, assign) XHHUDType hudType;
@property (nonatomic, copy) NSString *text;
@end

