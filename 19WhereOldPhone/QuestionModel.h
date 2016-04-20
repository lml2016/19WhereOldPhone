//
//  QuestionModel.h
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"
@interface QuestionModel : NSObject

@property (nonatomic, assign) NSInteger parent_id;
@property (nonatomic,assign) NSInteger attribute_id;
@property (nonatomic,strong) NSString *attribute_name;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSMutableArray *values;
@property (nonatomic,assign) BOOL isMultiSelect;


@property (nonatomic,strong) NSMutableArray *selectIds;
@property (nonatomic,strong) NSMutableArray *selectNames;


@property (nonatomic, assign, getter = isOpened) BOOL opened;

//"attribute_id": 1,
//"attribute_name": "机身内存",
//"description": "",
//"values": [

-(QuestionModel *) initWithDictionary : (NSDictionary *)dic;

@end
