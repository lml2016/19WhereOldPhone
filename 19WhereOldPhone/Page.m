//
//  Page.m
//  Ergehui
//
//  Created by GL on 14-10-16.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import "Page.h"

@implementation Page



-(Page *) initWithDictionary : (NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.currentPage = (int)[[dic objectForKey:@"pageindex"] integerValue];
        self.pageSize = (int)[[dic objectForKey:@"pagesize"] integerValue];
         self.currentTotal = (int)[[dic objectForKey:@"total"] integerValue];
        
        if ([dic objectForKey:@"hasmore"] != nil) {
            self.more = [[dic objectForKey:@"hasmore"] boolValue];
        }else{
            if (self.currentTotal < self.pageSize) {
                self.more = NO;
            }
        }
        

    }
    return self;
}

@end
