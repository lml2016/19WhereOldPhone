//
//  Task.m
//  Aiyou
//
//  Created by GL on 15/2/28.
//  Copyright (c) 2015年 skywalker. All rights reserved.
//

#import "Task.h"

@implementation Task


-(Task *) initWithDictionary : (NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.hasFinishedTask = [[dic objectForKey:@"hasFinishedTask"] boolValue];
    }
    return self;
}
@end
