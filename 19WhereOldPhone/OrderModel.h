//
//  OrderModel.h
//  Aiyou
//
//  Created by Sniper on 16/2/29.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneModel.h"

@interface OrderModel : NSObject

@property (nonatomic,assign) NSInteger price;
@property (nonatomic,assign) NSInteger basePrice;
@property (nonatomic,strong) PhoneModel *phoneModel;


-(OrderModel *) initWithDictionary : (NSDictionary *)dic;



@end
