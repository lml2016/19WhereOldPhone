//
//  CollectionDataSource.m
//  Sniperbrowser
//
//  Created by guo liang on 13-11-21.
//  Copyright (c) 2013年 Simon Peter Grätzer. All rights reserved.
//

#import "CollectionDataSource.h"


@interface CollectionDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSString *headerIdentifier;
@property (nonatomic, copy) NSString *footerIdentifier;
@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy) SupplementaryViewConfigureBlock supplementaryconfigureBlock;

@end

@implementation CollectionDataSource


#pragma mark - 

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(CollectionViewCellConfigureBlock) configureCellBlock
{
  return  [self initWithItems:anItems cellIdentifier:aCellIdentifier headerIdentifier:nil footerIdentifier:nil configureCellBlock:configureCellBlock configureSupplementaryBlock:nil];
}



- (id) initWithItems:(NSArray *)anItems
      cellIdentifier:(NSString *)aCellIdentifier
    headerIdentifier:(NSString *)headerIdentifier
    footerIdentifier:(NSString *)footerIdentifier
  configureCellBlock:(CollectionViewCellConfigureBlock)configureCellBlock
configureSupplementaryBlock: (SupplementaryViewConfigureBlock)supplementaryconfigureBlock
{
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.headerIdentifier = headerIdentifier;
        self.footerIdentifier = footerIdentifier;
        self.configureCellBlock = [configureCellBlock copy];
        self.supplementaryconfigureBlock = [supplementaryconfigureBlock copy];
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.items.count && ((NSArray*)self.items[indexPath.section]).count) {
        return ((NSArray *)self.items[indexPath.section])[indexPath.row];
    }
    return nil;
}

#pragma mark - PSTCollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return ((NSArray *)self.items[section]).count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell,item,indexPath);

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
            viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    if (self.headerIdentifier && self.footerIdentifier) {
        return nil;
    }
    
    NSString *identifier = nil;
	if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
		identifier = self.headerIdentifier;
	} else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
		identifier = self.footerIdentifier;
	}
    UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    // TODO Setup view
    
    self.supplementaryconfigureBlock(kind,supplementaryView,indexPath);
    
    return supplementaryView;
}

@end
