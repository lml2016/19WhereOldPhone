//
//  BaseController.m
//  Wenba
//
//  Created by GL on 15/1/5.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//

#import "BaseController.h"
#import "UtilsMacro.h"
#import "AppMacro.h"

@interface BaseController() <UIGestureRecognizerDelegate>
{
}
@end

@implementation BaseController

- (void)viewDidLoad
{
    // Do any additional setup after loading the view, typically from a nib.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self setupKeyboard];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.defaultTop = self.view.top;
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark Responding to keyboard events

- (void) setupKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘高度变化通知，ios5.0新增的
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
}


- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
}

- (void) moveInputBarWithKeyboardHeight : (float )height withDuration : (float) duration
{
    
}

- (void) initTapView
{
    self.view.userInteractionEnabled = YES;
    if (!self.tapGesture) {
        self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTap:)];
    }
    [self.view addGestureRecognizer:self.tapGesture];
    
}

@end
