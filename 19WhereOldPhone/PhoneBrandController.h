//
//  PhoneBrandController.h
//  Ershouji
//
//  Created by GL on 14-10-9.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface PhoneBrandController : BaseController
@property (weak, nonatomic) IBOutlet UITableView *brandTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *brandSearchBar;

@end
