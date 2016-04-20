//
//  QuestionController.h
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneModel.h"
#import "BaseController.h"

@interface QuestionController : BaseController

@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) PhoneModel *phoneModel;

- (IBAction)CommitQuestionAction:(id)sender;



@end
