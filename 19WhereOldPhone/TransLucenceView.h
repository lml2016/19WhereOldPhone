//
//  TransLucenceView.h
//  Sniperbrowser
//


#import <UIKit/UIKit.h>
@protocol TransLucenceViewDelegate;

@interface TransLucenceView : UIView

@property(nonatomic,assign) id<TransLucenceViewDelegate> delegate;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIView *otherView;
@property (nonatomic,assign) BOOL show;

@end        


@protocol TransLucenceViewDelegate <NSObject>

@optional
- (void)transLucenceViewWillShow;
- (void)transLucenceViewOnShow;
- (void)transLucenceViewWillDismiss;
- (void)transLucenceViewOnDismiss;


@end