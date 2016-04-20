//
//  TransLucenceView.m
//  Sniperbrowser
//

#import "TransLucenceView.h"

@implementation TransLucenceView

- (void) initialize{
    //init your ivars here
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disShow)];
    
    [self addGestureRecognizer:tap];
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.0;
    self.hidden = YES;
}

- (id) initWithCoder:(NSCoder *)aCoder{
    if(self = [super initWithCoder:aCoder]){
        [self initialize];
    }
    return self;
}

- (id) initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        [self initialize];
    }
    return self;
}

- (void) setShow:(BOOL)show
{
    if (show) {
        [self toShow];
    }else{
        [self disShow];
    }
}

- (void) setTextField:(UITextField *)textField
{
    _textField = textField;
}

- (void)toShow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(transLucenceViewWillShow)]) {
        [self.delegate transLucenceViewWillShow];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.hidden = NO;
        self.alpha = 0.5;
        if (self.otherView) {
            self.otherView.hidden = NO;
        }
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(transLucenceViewOnShow)]) {
            [self.delegate transLucenceViewOnShow];
        }
    }];
}

- (void)disShow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(transLucenceViewWillDismiss)]) {
        [self.delegate transLucenceViewWillDismiss];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
        if (self.otherView) {
            self.otherView.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (self.otherView) {
            self.otherView.hidden = YES;
            self.otherView.alpha = 1;
        }
        [self.textField resignFirstResponder];
        if (self.delegate && [self.delegate respondsToSelector:@selector(transLucenceViewOnDismiss)]) {
            [self.delegate transLucenceViewOnDismiss];
        }
    }];
}

//- (void) showOtherView
//{
//
//}
//
//- (void) dismissOtherView
//{
//    
//}

@end
