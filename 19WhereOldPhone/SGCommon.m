//
//  SGCommon.m
//  Foxbrowser
//
//  Created by guo liang on 13-8-8.
//  Copyright (c) 2013年 Simon Peter Grätzer. All rights reserved.
//

#import "SGCommon.h"

@implementation SGCommon

+(void)log:(NSString*)value
{
         NSLog(@"--- %@ ---  ",value);
}
+(void)log:(NSString *)tag andValue:(NSString *)value
{
         NSLog(@"%@ ---   %@",tag,value);
}
+(void)log:(NSString *)tag andValue1:(BOOL)value
{
         NSLog(@"%@ ---   %i",tag,value);
}
+(void)log:(NSString *)tag andParam:(NSInteger) value
{
         NSLog(@"%@ ---   %d",tag,value);
}

+ (NSString*) stringWithUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+ (float) systemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (NSString *) getUrlHost:(NSString *)url
{
    return ((NSURL *)[NSURL URLWithString:url]).host;
}

+ (NSString *) getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];

}
+(NSString *) getLibraryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
}

+(NSString*) uuid
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * result =[defaults objectForKey:@"uid"];
    if (!result) {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        [defaults setObject:result forKey:@"uid"];
        [defaults synchronize];
    }
    return result;
}

+(NSString *) getDate : (NSTimeInterval) time withFormat : (NSString *)format
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:time / 1000.0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:d];
}

+(NSString *) getDate : (NSTimeInterval) time
{
    return [self getDate:time withFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *) transFileTime : (int) time
{
    return [NSString stringWithFormat:@"%d:%02d",
                         time / 60,
                         time % 60, nil];
}

+ (NSString*) formatTimeFromSeconds:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}


+ (UIImage *)blurryImage:(UIImage *)image withContext : (CIContext *)context  withBlurLevel:(CGFloat)blur {
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    if (!context) {
        context =[CIContext contextWithOptions:nil];
    }
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    return [UIImage imageWithCGImage:outImage];
}

+ (NSInteger) calculateHeight : (int) width withFontSize : (int) size withText : (NSString *)contentText
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 0.0f, width, CGFLOAT_MAX)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:size];
    label.text = contentText;
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    [label sizeToFit];
    return label.frame.size.height;
}

+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+ (NSString *)createRandomCode
{

    NSString *code = @"";
    for (int i = 0; i < 4; i++) {
     int value = (arc4random() % 10);
        code = [NSString stringWithFormat:@"%d%@",value,code];
    }
    return code;
}


+ (UIImage *) createQRImage : (NSString *)kText
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [kText dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:0.5
                                   orientation:UIImageOrientationUp];
    
    // Resize without interpolating
    UIImage *resized = [self resizeImage:image
                             withQuality:kCGInterpolationNone
                                    rate:5.0];
    return resized;
    
}
+ (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate
{
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (NSString *) sizeToString : (long long)fileSize
{
    
    return [NSByteCountFormatter stringFromByteCount:fileSize
                                          countStyle:NSByteCountFormatterCountStyleFile];
}


@end
