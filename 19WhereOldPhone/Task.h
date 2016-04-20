//
//  Task.h
//  Aiyou
//
//  Created by GL on 15/2/28.
//  Copyright (c) 2015年 skywalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic,assign) BOOL hasFinishedTask;

-(Task *) initWithDictionary : (NSDictionary *)dic;

@end
