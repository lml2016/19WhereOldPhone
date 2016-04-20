//
//  Page.h
//  Ergehui
//
//  Created by GL on 14-10-16.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject

@property (nonatomic,assign) BOOL more;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign) int totalPage;
@property (nonatomic,assign) int currentTotal;
@property (nonatomic,assign) int pageSize;
-(Page *) initWithDictionary : (NSDictionary *)dic;

@end
