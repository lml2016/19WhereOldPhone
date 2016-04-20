//
//  NetUtils.h
//  Wenba
//
//  Created by GL on 15/2/4.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SGCommon.h"
#import "ASIFormDataRequest.h"

@interface NetUtils : NSObject

+ (void) doGet : (NSURL *)url  withResultBlock : (ResultBlock)block;
+ (void) doGet2 : (NSURL *)url  withResultBlock : (ResultBlock2)block;
+ (void) doPost : (NSDictionary *)paramsDic withUrl : (NSURL *)url withResultBlock : (ResultBlock)block;
+ (void) doPost2 : (NSDictionary *)paramsDic withUrl : (NSURL *)url withResultBlock : (ResultBlock2)block;
+ (void) doPostMutipart : (NSDictionary *)paramsDic withUrl : (NSURL *)url withResultBlock : (ResultBlock)block;
@end
