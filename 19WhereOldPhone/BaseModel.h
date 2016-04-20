//
//  BaseModel.h
//  Ergehui
//
//  Created by GL on 14-10-17.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"
#import "Page.h"
#import "Task.h"

@interface BaseModel : NSObject

@property (nonatomic,strong) NSDictionary *data;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) Status *status;
@property (nonatomic,strong) Page *page;
@property (nonatomic,strong) Task *task;

+ (BaseModel *) parseJSonData:(NSData *)jsonData;
@end
