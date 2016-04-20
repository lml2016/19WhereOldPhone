//
//  SPTextField.m
//  Wenba
//
//  Created by GL on 15/2/2.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//

#import "SPTextField.h"

@implementation SPTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 40 , 5 );
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 40 , 5 );
}
@end
