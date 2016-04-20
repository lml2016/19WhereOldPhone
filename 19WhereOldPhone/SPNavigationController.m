//
//  SPNavigationController.m
//  Sniperlbo
//
//  Created by guo liang on 14-1-16.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import "SPNavigationController.h"

@interface SPNavigationController ()

@end

@implementation SPNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // 1.取出设置主题的对象
//    UINavigationBar *appearance = [UINavigationBar appearance];
//    
//    // 2.设置导航栏的背景图片
//    NSString *navBarBg = nil;
//    if (IOS7) { // iOS7
//        navBarBg = @"nav_bg_ios7";
//        
//        [appearance setBarTintColor:UIColorFromRGB(0x58c2f1)];
//        
//    } else { // 非iOS7
//        navBarBg = @"nav_bg";
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
////        [appearance setTintColor:UIColorFromRGB(0x58c2f1)];
//        [appearance setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
//    }
    
//    [appearance setTintColor:[UIColor whiteColor]];
    

//    [appearance setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    
    //    // 3.标题
    //    [navBar setTitleTextAttributes:@{
    //                                     UITextAttributeTextColor : [UIColor blackColor]
    //                                     }];
    //    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
