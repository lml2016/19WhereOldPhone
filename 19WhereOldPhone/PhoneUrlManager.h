//
//  PhoneUrlManager.h
//  Aiyou
//
//  Created by Sniper on 16/2/25.
//  Copyright © 2016年 skywalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneUrlManager : NSObject

#define HOST_PHONE @"http://api.taolehuan.com"

#define CID @"1000000022"

#define AUTH @"6625696-55C2-4466-gf98-566E9E18kh3"

//品牌列表
#define URL_PHONE_BAEND_LIST [NSString stringWithFormat:@"%@/API/CategoryBrand/GetBrandList?clientID=%@&authKey=%@&categoryID=1",HOST_PHONE,CID,AUTH]

//选择型号
#define URL_PHONE_TYPE_LIST(brandID) [NSString stringWithFormat:@"%@/API/Equipment/GetEquipmentList?clientID=%@&authKey=%@&pageSize=%d&brandID=%ld&categoryID=%d",HOST_PHONE,CID,AUTH,1000,brandID,1]

//设备评估
#define URL_PHONE_EVALUATED(deviceID) [NSString stringWithFormat:@"%@/API/Equipment/GetEquipment?clientID=%@&authKey=%@&id=%ld",HOST_PHONE,CID,AUTH,deviceID]

//生成订单
#define URL_PHONE_CREATE_ORDER(data) [NSString stringWithFormat:@"%@/API/Evaluation/GetPrice?clientID=%@&authKey=%@&data=%@&UserID=0",HOST_PHONE,CID,AUTH,data]

//发送手机验证码
#define URL_PHONE_SEND_SMS @"http://rr.19w.me/api/Product/SendCheckCode"

//提交订单
#define URL_PHONE_COMMIT_ORDER @"http://rr.19w.me/api/Product/PlaceOrder"
//上传图片
#define URL_PHONE_COMMIT_PIC @"http://rr.19w.me/api/AUploadFile/SavePhotos"

#define URL_PHONE_GET_TOKEN(sessionKey) [NSString stringWithFormat:@"http://xy.skywalker.19where.com/api/oauth2/requestCode?scope=api/user/getUserInfoByAccessToken&approval_prompt=force&client_id=125ef717364fc89cf4ff0e3a293b27f1&tate=aaa&access_type=offline&redirect_uri=http://rr.19w.me/&_json=1&response_type=token&sessionkey=%@",sessionKey]
@end
