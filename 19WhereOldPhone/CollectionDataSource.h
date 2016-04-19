//
//  CollectionDataSource.h
//  Sniperbrowser
//
//  Created by guo liang on 13-11-21.
//  Copyright (c) 2013年 Simon Peter Grätzer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item,NSIndexPath * indexPath);
typedef void (^SupplementaryViewConfigureBlock)(id kind , id view,NSIndexPath * indexPath);

@interface CollectionDataSource : NSObject <UICollectionViewDataSource>

//items 存放所有的section
@property (nonatomic, strong) NSArray *items;

- (id) initWithItems:(NSArray *)anItems
      cellIdentifier:(NSString *)aCellIdentifier
    headerIdentifier:(NSString *)headerIdentifier
    footerIdentifier:(NSString *)footerIdentifier
  configureCellBlock:(CollectionViewCellConfigureBlock)configureCellBlock
configureSupplementaryBlock: (SupplementaryViewConfigureBlock)supplementaryconfigureBlock;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CollectionViewCellConfigureBlock) configureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
