//
//  CornerButton.m
//  ChildSong
//
//  Created by GL on 14-2-25.
//  Copyright (c) 2014年 sniper. All rights reserved.
//

#import "CornerButton.h"

@implementation CornerButton

 BOOL animating;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CALayer *l = self.layer;
    [l setMasksToBounds:YES];
    [l setCornerRadius:self.bounds.size.width / 2];
}



- (void) startSpin {
    if (animating) {
        return;
    }
    animating = YES;
    [self spinWithOptions: UIViewAnimationOptionCurveEaseIn];

}

- (void) stopSpin {
    // set the flag to stop spinning after one last 90 degree increment
    animating = NO;
}


- (void) spinWithOptions: (UIViewAnimationOptions) options {
    // this spin completes 360 degrees every 2 seconds
    [UIView animateWithDuration: 0.8f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         self.transform = CGAffineTransformRotate(self.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (animating) {
                                 // if flag still set, keep spinning with constant speed
                                 [self spinWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 // one last spin, with deceleration
                                 [self spinWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}


@end
