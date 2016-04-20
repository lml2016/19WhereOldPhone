//
//  PhoneModel.h
//  Ershouji
//
//  Created by GL on 14-10-8.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneBrand.h"

@interface PhoneModel : NSObject


@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic,strong) NSString *product_name;
@property (nonatomic, strong) PhoneBrand *phoneBrand;

@property (nonatomic, assign) int price;
@property (nonatomic, assign) int min_price;
@property (nonatomic, assign) int max_price;

@property (nonatomic,strong) NSString *product_image_url;

-(PhoneModel *) initWithDictionary : (NSDictionary *)dic;


@end
