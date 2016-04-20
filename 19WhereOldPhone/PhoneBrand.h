//
//  PhoneBrand.h
//  Ershouji
//
//  Created by GL on 14-10-8.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhoneBrand : NSObject

@property (nonatomic, assign) NSInteger brand_id;
@property (nonatomic, strong) NSString *brand_name;
@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) NSString *sortLetters;
@property (nonatomic, strong) NSMutableArray *products;

@property (nonatomic, assign) NSInteger sectionNumber;

-(PhoneBrand *) initWithDictionary : (NSDictionary *)dic;


@end
