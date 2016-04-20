//
//  OrderModel.m
//  Aiyou
//
//  Created by Sniper on 16/2/29.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(OrderModel *) initWithDictionary : (NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        self.price = [[dic objectForKey:@"EvaluationPrice"] integerValue];
        self.basePrice = [[dic objectForKey:@"BasePrice"] integerValue];
        
    }
    return self;
}


@end
