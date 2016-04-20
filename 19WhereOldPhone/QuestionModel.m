//
//  QuestionModel.m
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opened = YES;
    }
    return self;
}

-(QuestionModel *) initWithDictionary : (NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        self.selectIds = [[NSMutableArray alloc] init];
        self.selectNames = [[NSMutableArray alloc] init];
        self.opened = YES;
        self.parent_id = [[dic objectForKey:@"ParentID"] integerValue];
        self.attribute_id = [[dic objectForKey:@"AttributesID"] integerValue];
        self.attribute_name = [dic objectForKey:@"AttributesTitle"];
        self.desc = [dic objectForKey:@"Description"];
        self.values = [[NSMutableArray alloc] init];
        self.isMultiSelect = [[dic objectForKey:@"IsMultiSelect"] integerValue] == 1;
    }
    return self;
}

@end
