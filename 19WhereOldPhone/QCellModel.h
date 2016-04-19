//
//  QCellModel.h
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionModel.h"

@interface QCellModel : NSObject

@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic,assign) NSInteger value_id;
@property (nonatomic,strong) NSString *value_name;
@property (nonatomic,assign) BOOL isSelected;


-(QCellModel *) initWithQuestionModel : (QuestionModel *)dic;



//"value_id": 1,
//"value_name": "8G",
//"adjust_price": 0

@end
