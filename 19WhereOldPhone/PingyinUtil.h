//
//  PingyinUtil.h
//  Ershouji
//
//  Created by GL on 14-10-9.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PingyinUtil : NSObject


+(NSString *) getFirstLetter : (NSString *) hanzi;
+(char) pinyinFirstLetter : (unsigned short )hanzi;
@end
