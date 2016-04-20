//
//  AspectFitImageView.m
//  Aiyou
//
//  Created by Sniper on 15/10/14.
//  Copyright © 2015年 skywalker. All rights reserved.
//

#import "AspectFitImageView.h"

@implementation AspectFitImageView


- (CGSize)intrinsicContentSize
{
    CGSize s =[super intrinsicContentSize];
    
    s.height = self.frame.size.width / self.image.size.width  * self.image.size.height;
    
    return s;
}
@end
