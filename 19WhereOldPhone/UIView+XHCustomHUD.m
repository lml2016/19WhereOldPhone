//
//  UIView+XHCustomHUD.m
//  XHShockHUD
//
//  Created by 曾 宪华 on 13-12-13.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "UIView+XHCustomHUD.h"
#import <objc/runtime.h>
#import "XHHUDView.h"
#define degreesToRadian(x) (M_PI * (x) / 180.0)

@implementation UIView (XHCustomHUD)

static char UIViewHUD;

#pragma mark - getter / setter

- (void)setHudView:(XHHUDView *)hudView {
    [self willChangeValueForKey:@"hudView"];
    objc_setAssociatedObject(self, &UIViewHUD,
                             hudView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"hudView"];
}

- (XHHUDView *)hudView {
    return objc_getAssociatedObject(self, &UIViewHUD);
}

#pragma mark - Public api

- (XHHUDView *)showHUDWithText:(NSString *)text hudType:(XHHUDType)hudType animationType:(XHHUDAnimationType)animationType {
   return [self showHUDWithText:text hudType:hudType animationType:animationType delay:0];
}

- (XHHUDView *)showHUDWithText:(NSString *)text hudType:(XHHUDType)hudType animationType:(XHHUDAnimationType)animationType delay:(NSTimeInterval)delay {
    return [self showHUDWithText:text hudSize:CGSizeMake(130, 130) hudType:hudType animationType:animationType delay:delay];
}

- (void) showHud : (NSString *)text
{
    [self showHUDWithText:text hudSize:CGSizeMake(130, 130) hudType:kXHHUDSuccess animationType:kXHHUDFade delay:1.5];
}

- (XHHUDView *)showHUDWithText:(NSString *)text
                hudSize:(CGSize)hudSize
                hudType:(XHHUDType)hudType
          animationType:(XHHUDAnimationType)animationType
                  delay:(NSTimeInterval)delay {
    XHHUDView *hudView = [[XHHUDView alloc] initWithFrame:CGRectZero];
    
    CGRect hudViewFrame = hudView.frame;
    hudViewFrame.size = hudSize;
    hudView.frame = hudViewFrame;

    hudView.center = self.center;
    hudView.text = text;
    hudView.hudType = hudType;
    hudView.alpha = 0.0;
    [self addSubview:hudView];
    self.hudView = hudView;
    
    switch (animationType) {
        case kXHHUDFade:
            [self _fadeAnimationWithHUDView:hudView delay:delay];
            break;
        default:
            break;
    }
    return hudView;
}

- (XHHUDView *)showHUDWithText:(NSString *)text
               hudFrame:(CGRect)hudRect
                hudType:(XHHUDType)hudType
          animationType:(XHHUDAnimationType)animationType
                  delay:(NSTimeInterval)delay
{
    XHHUDView *hudView = [[XHHUDView alloc] initWithFrame:CGRectZero];
    hudView.frame = hudRect;
    hudView.text = text;
    hudView.hudType = hudType;
    hudView.alpha = 0.0;
    [self addSubview:hudView];
    self.hudView = hudView;
    
    switch (animationType) {
        case kXHHUDFade:
            [self _fadeAnimationWithHUDView:hudView delay:delay];
            break;
        default:
            break;
    }
    return hudView;
}

- (void)_fadeAnimationWithHUDView:(XHHUDView *)hudView
                    delay:(NSTimeInterval)delay {
    void (^animations)() = ^{
        hudView.alpha = 1.0;
    };
    
    void (^completion)(BOOL finish) = ^(BOOL finishi) {
        if (delay) {
            [self dismissHUD:hudView delay:delay];
        }
    };
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone;
    [UIView animateWithDuration:0.3 delay:0 options:options animations:animations completion:completion];
}

- (void)dismissHUD:(XHHUDView *)hudView delay:(NSTimeInterval)delay {
    [UIView animateWithDuration:0.4 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        hudView.alpha = .0f;
//        hudView.transform = CGAffineTransformMakeScale(0.65, 0.65);
    } completion:^(BOOL finished) {
        [hudView removeFromSuperview];
    }];
}

@end
