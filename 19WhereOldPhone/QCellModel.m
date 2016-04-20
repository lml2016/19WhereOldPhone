//
//  QCellModel.m
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "QCellModel.h"

@implementation QCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isSelected = NO;
    }
    return self;
}

-(QCellModel *) initWithQuestionModel : (QuestionModel *)quesiton
{
    self = [super init];
    
    if (self) {
        
        self.parent_id =quesiton.parent_id;
        self.value_id = quesiton.attribute_id;
        self.value_name = quesiton.attribute_name;
        self.isSelected = NO;
    }
    return self;
}


@end
