
#import "HeadView.h"
#import "QuestionModel.h"
#import "UIView+Utils.h"

@interface HeadView()
{
    UIButton *_bgButton;
    UILabel *_numLabel;
    UIImageView *_checkImageView;
}
@end

@implementation HeadView

+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *headIdentifier = @"header";
    
    HeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"question_header_normal"] forState:UIControlStateNormal];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"question_header_press"] forState:UIControlStateHighlighted];
        [bgButton setImage:[UIImage imageNamed:@"indicator_unexpanded"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        bgButton.titleLabel.textColor = [UIColor blackColor];
        bgButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:numLabel];
        _numLabel = numLabel;
        
        _checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_green_checked"]];
        _checkImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_checkImageView];
    }
    return self;
}

- (void)headBtnClick
{
//    self.question.opened = !self.question.opened;
//
//    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
//        [_delegate clickHeadView];
//    }
}
- (void)setQuestion:(QuestionModel *)question withSection : (NSInteger) section
{
    _question =question;
    [_bgButton setTitle:[NSString stringWithFormat:@"%ld. %@",(long)section + 1,question.attribute_name] forState:UIControlStateNormal];
    if (question.selectIds.count != 0) {
        _checkImageView.image = [UIImage imageNamed:@"icon_green_checked"];
    }else{
         _checkImageView.image = [UIImage imageNamed:@"icon_green_uncheck"];
    }
    _checkImageView.contentMode = UIViewContentModeScaleAspectFit;
}


- (void)didMoveToSuperview
{
    _bgButton.imageView.transform = self.question.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    _checkImageView.frame = CGRectMake(self.frame.size.width - 30, (self.height - 15) / 2, 15, 15);
}

@end
