//
//  UtilsMacro.h
//  Wenba
//
//  Created by GL on 15/1/5.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//

#ifndef Wenba_UtilsMacro_h
#define Wenba_UtilsMacro_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

typedef void (^TableViewCellConfigureBlock)(id cell, id item,id indexPath);
typedef void (^TableViewDeleteRowBlock)(id indexPath);

typedef  enum{
    SUCCESS = 1,
    FINISH = 0,
    ERROR = -1,
} resultCode;

typedef  enum{
    RELOAD = 0,
    LOADMORE = 1,
    SEARCH = 2,
    SEARCH_LOADMORE = 3,
} loadType;

#endif
