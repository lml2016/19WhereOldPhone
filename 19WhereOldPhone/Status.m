//
//  Status.m
//  Ergehui
//
//  Created by GL on 14-10-16.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import "Status.h"

@implementation Status

-(Status *) initWithDictionary : (NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.success = [[dic objectForKey:@"success"] boolValue];
        self.code = (int)[[dic objectForKey:@"code"] integerValue];
        self.message = [dic objectForKey:@"message"];
    }
    return self;
}

@end
