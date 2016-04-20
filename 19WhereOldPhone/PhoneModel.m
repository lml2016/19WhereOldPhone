//
//  PhoneModel.m
//  Ershouji
//
//  Created by GL on 14-10-8.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "PhoneModel.h"

@implementation PhoneModel

-(PhoneModel *) initWithDictionary : (NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        self.product_id = [[dic objectForKey:@"EquipmentID"] integerValue];
        self.product_name = [dic objectForKey:@"EquipmentTitle"];
        self.product_image_url = [dic objectForKey:@"EquipmentImg"];
        
    }
    return self;
}


@end
