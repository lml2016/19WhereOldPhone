//
//  QuestionCell.m
//  Ershouji
//
//  Created by GL on 14-10-10.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"QuestionCell" bundle:nil];
}

- (void) configCell : (QCellModel *)entity withCurrentQuestionSelectId : (NSArray *) selectIds  withIndexPath : (NSIndexPath *)indexPath
{
    if ([selectIds containsObject:[NSNumber numberWithInt:entity.value_id]]) {
        [self.checkImageView setImage:[UIImage imageNamed:@"input_yes"]];
    }else{
        [self.checkImageView setImage:[UIImage imageNamed:@"input_n"]];
    }
    self.nameLabel.text = entity.value_name;
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
