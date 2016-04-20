//
//  BaseModel.m
//  Ergehui
//
//  Created by GL on 14-10-17.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (BaseModel *) parseJSonData:(NSData *)jsonData
{
    NSError *error;
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (jsonDic && jsonDic.count) {
        NSDictionary *data = [jsonDic objectForKey:@"data"];
        NSArray *dataList = [jsonDic objectForKey:@"datalist"];
        NSDictionary *statusDic = [jsonDic objectForKey:@"status"];
        NSDictionary *pageDic = [jsonDic objectForKey:@"page"];
         NSDictionary *taskDic = [jsonDic objectForKey:@"task"];
        Page *page = nil;
        if (pageDic && pageDic != [NSNull null]) {
           page = [[Page alloc] initWithDictionary:pageDic];
        }
        
        Status *status = [[Status alloc] initWithDictionary:statusDic];
        Task *task = [[Task alloc] initWithDictionary:taskDic];
        
        BaseModel *baseModel = [[BaseModel alloc] init];
        baseModel.data = data;
        baseModel.dataList = dataList;
        baseModel.page = page;
        
        baseModel.status = status;
        baseModel.task = task;
        return baseModel;
    }
    return nil;
}



@end
