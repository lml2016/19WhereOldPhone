//
//  NetUtils.m
//  Wenba
//
//  Created by GL on 15/2/4.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//

#import "NetUtils.h"


@implementation NetUtils

+ (void) doGet : (NSURL *)url  withResultBlock : (ResultBlock)block
{
    DLog(@"doGet = %@",url.absoluteString);
    ASIHTTPRequest *_asiRequest = [ASIHTTPRequest requestWithURL:url];
    
    [_asiRequest setCompletionBlock:^{
        BaseModel *baseModel = [BaseModel parseJSonData:[_asiRequest responseData]];
        block(baseModel);
    }];
    [_asiRequest setFailedBlock:^{
        block(nil);
    }];
    [_asiRequest startAsynchronous];
}


+ (void) doGet2 : (NSURL *)url  withResultBlock : (ResultBlock2)block
{
    DLog(@"doGet = %@",url.absoluteString);
    ASIHTTPRequest *_asiRequest = [ASIHTTPRequest requestWithURL:url];
    
    [_asiRequest setCompletionBlock:^{
        block([[NSString alloc] initWithData:[_asiRequest responseData] encoding:NSUTF8StringEncoding]);
    }];
    [_asiRequest setFailedBlock:^{
        block(nil);
    }];
    [_asiRequest startAsynchronous];
}





+ (void) doPost : (NSDictionary *)paramsDic withUrl : (NSURL *)url withResultBlock : (ResultBlock)block
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSArray *keys = [paramsDic allKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        id value = [paramsDic objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [request setPostValue:value forKey:key];
        }else if([value isKindOfClass:[UIImage class]]){
            NSData *imageData = UIImagePNGRepresentation(value);
            [request setData:imageData withFileName:@"temp.png" andContentType:@"image/png" forKey:key];
        }
    }
    [NetUtils setupParams:paramsDic withRequest:request];
    [request setRequestMethod:@"POST"];//设置数据接受方式为post
    
    [request setCompletionBlock:^{
        DLog(@"success");
        BaseModel *baseModel = [BaseModel parseJSonData:[request responseData]];
        block(baseModel);
    }];
    
    [request setFailedBlock:^{
        block(nil);
        DLog(@"%@ ",request.error.description);
        
    }];
    request.delegate = self;
    [request startAsynchronous];
}


+ (void) doPost2 : (NSDictionary *)paramsDic withUrl : (NSURL *)url withResultBlock : (ResultBlock2)block
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSArray *keys = [paramsDic allKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        id value = [paramsDic objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [request setPostValue:value forKey:key];
        }else if([value isKindOfClass:[UIImage class]]){
            NSData *imageData = UIImagePNGRepresentation(value);
            [request setData:imageData withFileName:@"temp.png" andContentType:@"image/png" forKey:key];
        }
    }
    if (paramsDic) {
     [NetUtils setupParams:paramsDic withRequest:request];
    }
    
    [request setRequestMethod:@"POST"];//设置数据接受方式为post
    
    [request setCompletionBlock:^{
        DLog(@"success");
        block([[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding]);
    }];
    
    [request setFailedBlock:^{
        block(nil);
        DLog(@"%@ ",request.error.description);
        
    }];
    request.delegate = self;
    [request startAsynchronous];
}

/**
 * multipart 方式
 **/
+ (void) doPostMutipart : (NSDictionary *)paramsDic withUrl : (NSURL *)url withResultBlock : (ResultBlock)block
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostFormat:ASIMultipartFormDataPostFormat];
    
    NSArray *keys = [paramsDic allKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        id value = [paramsDic objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [request setPostValue:value forKey:key];
        }else if([value isKindOfClass:[UIImage class]]){
            NSData *imageData = UIImagePNGRepresentation(value);
            [request setData:imageData withFileName:[NSString stringWithFormat:@"%@.png",key] andContentType:@"image/png" forKey:key];
        }else if([value isKindOfClass:[NSData class]]){
            //[request setData:value forKey:key];
            [request setData:value withFileName:[NSString stringWithFormat:@"%@.mp4",key] andContentType:@"" forKey:key];
        }else if([value isKindOfClass:[NSURL class]]){
            [request setFile:[value absoluteString] forKey:key];
        }
    }
    [NetUtils setupParams:paramsDic withRequest:request];
    [request setRequestMethod:@"POST"];//设置数据接受方式为post
    
    [request setCompletionBlock:^{
        DLog(@"success");
        BaseModel *baseModel = [BaseModel parseJSonData:[request responseData]];
        block(baseModel);
    }];
    
    [request setFailedBlock:^{
        block(nil);
        DLog(@"%@ ",request.error.description);
        
    }];
    request.delegate = self;
    [request startAsynchronous];
    
}

+ (void) setupParams : (NSDictionary *)dataDic withRequest : (ASIFormDataRequest *)request
{
    NSArray *keys = [dataDic allKeys];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *value = [dataDic objectForKey:key];
        [request setPostValue:value forKey:key];
    }
}

@end
