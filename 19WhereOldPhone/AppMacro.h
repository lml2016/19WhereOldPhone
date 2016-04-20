//
//  AppMacro.h
//  Wenba
//
//  Created by GL on 15/1/5.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//
#import "SGCommon.h"
#import "SVProgressHUD.h"
#import "NetUtils.h"
#import "UrlManager.h"


#define DEDUG YES

#define RECORD_TIME 8
#define BITRATE  100 * 1000  //视频码率

#define IS_IDENTITY 0

#define UMENG_KEY @"54f03a76fd98c54dc1000869"
#define WX_APPID @"wx49a9093ddd0277d3"
#define WX_APPSECRET @"25a03a55b59c0ef3b2f657d54d193100"

#define KEFU_APP_KEY @"71a7126cdddcf76f4a50aa52ded87d7e"

#define GETUI_APP_ID @"mm0xbwBKbtAgmwEQ81nAt3"
#define GETUI_APP_KEY @"Qa4e4gSnjQ7JvIDnnflWH4"
#define GETUI_APP_SECRET @"KUVmTRx06p55gxGtT9leP"

#ifndef Wenba_AppMacro_h
#define Wenba_AppMacro_h

#define BUTTON_TAG_START 100
#define TABBAR_HEIGHT 50
#define NAV_BG_COLOR 0xff9100

#define BACKGROUND_COLOR 0xf4f4f4
#define DIVIER_COLOR 0xd1d1d1
#define GREEN_BUTTON_NORMAL 0x2CB3B7
#define GREEN_BUTTON_PRESS 0x28a2a7
#define ORANGE 0xeb7827

#define WHITE_BUTTON_PRESS 0xe5e5e5

#define CF_PROGRESS 0xf1d534
#define CF_PROGRESS_SECOND 0xfeef94

#define SW_PROGRESS 0xfe6464
#define SW_PROGRESS_SECOND 0xffcfcf

#define TAG_MOVE_DURATION 0.4

#define PAGESIZE 15

#define QUESTION_CELL_IMAGE_HEIGHT 100

typedef  enum{
    caifu = 1,
    shengwang = 2,
    tianxingbi = 3
} balanceType;


typedef  enum{
    PIC = 1,
    VIDEO = 2,
} articleType;

typedef  enum{
    NEW = 0,
    HOT = 1,
    ME = 2
} VIDEO_TYPE;

typedef  enum{
    NEW_ARTICLE = 0,
    ME_ARTICLE = 1
} ARTICLE_TYPE;


typedef NS_ENUM(NSInteger, CameraType) {
    Front,
    Back
};




#endif


