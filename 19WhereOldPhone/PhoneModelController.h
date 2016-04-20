//
//  PhoneModelController.h
//  Ershouji
//
//  Created by GL on 14-10-9.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneBrand.h"
#import "BaseController.h"

@interface PhoneModelController : BaseController
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) PhoneBrand *phoneBrand;
@property (weak, nonatomic) IBOutlet UISearchBar *modelSearchBar;

@end
