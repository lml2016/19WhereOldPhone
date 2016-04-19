//
//  SGCommon.h
//  Foxbrowser
//
//  Created by guo liang on 13-8-8.
//  Copyright (c) 2013年 Simon Peter Grätzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "UtilsMacro.h"
#import <UIKit/UIKit.h>



#if DEBUG
#define logtrace() NSLog(@"%s():%d ", __func__, __LINE__)
#define logdebug(format, ...) NSLog(@"%s():%d "format, __func__, __LINE__, ##__VA_ARGS__)
#else
#define logdebug(format, ...)
#define logtrace()
#endif

#define loginfo(format, ...) NSLog(@"%s():%d "format, __func__, __LINE__, ##__VA_ARGS__)

#define logerror(format, ...) NSLog(@"%s():%d ERROR "format, __func__, __LINE__, ##__VA_ARGS__)


#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

// 账户信息

#define DWACCOUNT_USERID @"5D5FEA85284CCD9B"

#define DWACCOUNT_APIKEY @"NHAzgFAxxeOKiTlSG0WkajeJwteJqunU"

//typedef void (^LoadDataResultBlock)(resultCode resultCode,NSMutableArray *resultArray);
typedef void (^LoadDataResultBlock)(resultCode resultCode,NSMutableArray *resultArray,id headerData);

typedef void (^ResultBlock)(BaseModel *resultModel);
typedef void (^ResultBlock2)(NSString *result);

#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif


@interface SGCommon : NSObject

+(void)log:(NSString*)value;
+(void)log:(NSString *)tag andValue:(NSString*)value;
+(void)log:(NSString *)tag andValue1:(BOOL)value;
+(void)log:(NSString *)tag andParam:(NSInteger )value;
+ (NSString*) stringWithUUID;
+ (float) systemVersion;
+ (NSString *) getUrlHost:(NSString *)url;
+ (NSString *) getDocumentPath;
+(NSString *) getLibraryPath;
+ (NSString*) uuid;
+(NSString *) getDate : (NSTimeInterval) time;
+(NSString *) getDate : (NSTimeInterval) time withFormat : (NSString *)format;
+ (NSString *) transFileTime : (int) time;
+ (NSString*) formatTimeFromSeconds:(int)totalSeconds;
+ (UIImage *)blurryImage:(UIImage *)image withContext : (CIContext *)context  withBlurLevel:(CGFloat)blur;
+ (NSInteger) calculateHeight : (int) width withFontSize : (int) size withText : (NSString *)contentText;
+(BOOL) isValidateMobile:(NSString *)mobile;
+ (NSString *)createRandomCode;
+ (UIImage *) createQRImage : (NSString *)kText;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+ (NSString *) sizeToString : (long long)fileSize;


@end
