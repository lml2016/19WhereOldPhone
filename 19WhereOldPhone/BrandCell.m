//
//  BrandCell.m
//  Ershouji
//
//  Created by GL on 14-10-9.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import "BrandCell.h"
#import "PhoneBrand.h"
#import "PhoneModel.h"

@implementation BrandCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"BrandCell" bundle:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) configCell : (PhoneBrand *)entity withIndexPath : (NSIndexPath *)indexPath
{
    self.nameLabel.text = entity.brand_name;
}

- (void) configCellPhoneModel : (PhoneModel *)entity withIndexPath : (NSIndexPath *)indexPath
{
    self.nameLabel.text = entity.product_name;
}
@end
