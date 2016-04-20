//
//  BrandCell.h
//  Ershouji
//
//  Created by GL on 14-10-9.
//  Copyright (c) 2014年 19where. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhoneBrand,PhoneModel;
@interface BrandCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (UINib *)nib;
- (void) configCell : (PhoneBrand *)entity withIndexPath : (NSIndexPath *)indexPath;
- (void) configCellPhoneModel : (PhoneModel *)entity withIndexPath : (NSIndexPath *)indexPath;
@end
