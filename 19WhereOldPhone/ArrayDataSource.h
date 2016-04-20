//
//  ArrayDataSource.h
//  Sniperbrowser
//
//  Created by stane smith on 10/29/13.
//  Copyright (c) 2013 Simon Peter Grätzer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacro.h"
#import <UIKit/UIKit.h>

//typedef void (^TableViewCellConfigureBlock)(id cell, id item,id indexPath);

@interface ArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (assign) BOOL canEdit;
@property (nonatomic,copy)TableViewDeleteRowBlock deleteRowBlock;

- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;


@end
