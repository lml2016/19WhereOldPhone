

#import <UIKit/UIKit.h>
@class QuestionModel;

@protocol HeadViewDelegate <NSObject>

@optional

- (void)clickHeadView;

@end

@interface HeadView : UITableViewHeaderFooterView

@property (nonatomic, weak) QuestionModel *question;

@property (nonatomic, weak) id<HeadViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;
- (void)setQuestion:(QuestionModel *)question withSection : (NSInteger) section;

@end
