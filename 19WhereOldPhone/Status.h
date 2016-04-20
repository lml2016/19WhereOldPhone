//
//  Status.h
//  Ergehui
//
//  Created by GL on 14-10-16.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Status : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,assign) int code;
@property (nonatomic,strong) NSString *message;


-(Status *) initWithDictionary : (NSDictionary *)dic;
@end
