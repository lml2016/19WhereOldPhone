//
//  QuestionCell.h
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCellModel.h"
@interface QuestionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

+ (UINib *)nib;
- (void) configCell : (QCellModel *)entity withCurrentQuestionSelectId : (NSArray *) selectIds  withIndexPath : (NSIndexPath *)indexPath;
@end
