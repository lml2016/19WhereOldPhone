//
//  PhoneBrand.m
//  Ershouji
//
//  Created by GL on 14-10-8.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "PhoneBrand.h"

@implementation PhoneBrand


-(PhoneBrand *) initWithDictionary : (NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        self.brand_id = [[dic objectForKey:@"BrandID"] integerValue];
        self.brand_name = [dic objectForKey:@"BrandTitle"];
        self.subtitle = [dic objectForKey:@"Subtitle"];
        
    }
    return self;
}

@end
