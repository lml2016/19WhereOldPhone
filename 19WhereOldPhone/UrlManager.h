//
//  UrlManager.h
//  Wenba
//
//  Created by GL on 15/1/6.
//  Copyright (c) 2015年 canpoint. All rights reserved.
//

#ifndef Wenba_UrlManager_h
#define Wenba_UrlManager_h

#define PAGESIZE_QUESTION 20

#define PAGESIZE_VIDEO 20

#endif

#define HOST @"http://xy.skywalker.19where.com"
#define HOST_Debug @"http://192.168.19.99:8080"

#define SECRET_HELP @"http://mp.weixin.qq.com/s?__biz=MjM5Mjg2ODI0NQ==&mid=202997077&idx=1&sn=f45c8b235504976a4323c4ced2bbedbd#rd"

/**登录*/
#define URL_LOGIN [NSString stringWithFormat:@"%@/api/promoter/loginByThirdAccount",HOST]
/**工号登录*/
#define URL_LOGIN_STAFF [NSString stringWithFormat:@"%@/api/promoter/loginByStaffCode",HOST]



/**获取用户信息*/
#define URL_GET_USRINFO(sessionkey,thirdSesstionkey) [NSString stringWithFormat:@"%@/api/promoter/getprofile?sessionkey=%@&third_sessionkey=%@",HOST,sessionkey,thirdSesstionkey]

/**获取产品列表*/
#define URL_PRODUCT_LIST(sessionkey) [NSString stringWithFormat:@"%@/api/promoter/getproductlist?sessionkey=%@",HOST,sessionkey]
/**获取CPS产品列表*/
#define URL_CPS_PRODUCT_LIST(sessionkey) [NSString stringWithFormat:@"%@/api/promoter/getProductListByPaymentShare?sessionkey=%@",HOST,sessionkey]

/**获取无SDK产品列表*/
#define URL_PRODUCT_LIST_NOSDK(sessionkey) [NSString stringWithFormat:@"%@/api/promoter/getProductListWithoutSdk?sessionkey=%@",HOST,sessionkey]

/**获取任务列表*/
#define URL_TASK_LIST(sessionkey,taskId) [NSString stringWithFormat:@"%@/api/task/getTaskList?sessionkey=%@&task_type=%d",HOST,sessionkey,taskId]
/**获取指定任务获取任务*/
#define URL_TASK_BY_CODE(sessionkey) [NSString stringWithFormat:@"%@/api/task/getTaskByCode?sessionkey=%@&taskcode=login",HOST,sessionkey]

/**领取任务*/
#define URL_GET_TASK [NSString stringWithFormat:@"%@/api/task/setTask",HOST]

/**设置邮件*/
#define URL_SET_MAIL [NSString stringWithFormat:@"%@/api/mail/setMail",HOST]


/**获取产品详细信息*/
#define URL_PRODUCT_DETAIL(sessionkey,productId) [NSString stringWithFormat:@"%@/api/promoter/getFirstPmtProductdetails?sessionkey=%@&product_id=%ld",HOST,sessionkey,productId]


#define URL_USER_INFO [NSString stringWithFormat:@"%@/appjson/info/",HOST]

#define URL_VIDEO_UNIT(gradeId,subjectId,cateType) [NSString stringWithFormat:@"%@/Index/AppShop/get_unit_by_type/subject_id/%@/nianji_id/%@/cate_type_id/%d",HOST2,subjectId,gradeId,cateType]
/**获取排行类型*/
#define URL_RANK_MENU(sessionkey) [NSString stringWithFormat:@"%@/api/ranklist/getRankingTypeList?sessionkey=%@",HOST,sessionkey]
/**获取排行*/
#define URL_RANK(sessionkey,type) [NSString stringWithFormat:@"%@/api/ranklist/getRankingListByType?sessionkey=%@&type=%d",HOST,sessionkey,type]
/**获取个人（财富/声望/积分）历史*/
#define URL_BALANCE(sessionkey,type,pageindex) [NSString stringWithFormat:@"%@/api/promoter/getBalancelogByCurrencyType?sessionkey=%@&currency_type=%d&pageindex=%d&pagesize=%d",HOST,sessionkey,type,pageindex,PAGESIZE]
/**提现历史记录*/
#define URL_AMOUNT_HIS(sessionKey,pageindex) [NSString stringWithFormat:@"%@/api/promoter/getCheckoutLog?sessionkey=%@&pageindex=%d&pagesize=%d",HOST,sessionKey,pageindex,PAGESIZE]


/**推广者-兑换天行币*/
#define URL_EXCHANGE [NSString stringWithFormat:@"%@/api/promoter/exchange",HOST]

/**设置个人信息(帐号)*/
#define URL_SET_PROFILE [NSString stringWithFormat:@"%@/api/promoter/setprofile",HOST]
/**提现*/
#define URL_AMOUNT(sessionKey,amount) [NSString stringWithFormat:@"%@/api/promoter/checkout?sessionkey=%@&amount=%d",HOST,sessionKey,amount]
/**提现计算*/
#define URL_AMOUNT_CALCU(sessionKey,amount) [NSString stringWithFormat:@"%@/api/promoter/calcCheckoutFee?sessionkey=%@&amount=%d",HOST,sessionKey,amount]
/**发送手机验证码*/
#define URL_SEND_SMS(sessionKey,phoneNum) [NSString stringWithFormat:@"%@/api/promoter/getCellphoneVerifyCode?sessionkey=%@&cellphone=%@",HOST,sessionKey,phoneNum]

/**站内信*/
#define URL_MAIL(sessionKey) [NSString stringWithFormat:@"%@/api/mail/getMailList?sessionkey=%@",HOST,sessionKey]
/**绑定推送用户*/
#define URL_BIND_PUSH [NSString stringWithFormat:@"%@/api/promoter/bindPushUser",HOST]
/**领取任务*/
#define URL_SET_TASK [NSString stringWithFormat:@"%@/api/task/setTask",HOST]
/**提交身份证*/
#define URL_SUBMIT_IDENTIFY [NSString stringWithFormat:@"%@/api/promoter/setprofile4Idcard",HOST]
/**个人WEB-获取页面url*/
#define URL_APP_WEB_URL(sessionKey) [NSString stringWithFormat:@"%@/api/promoter/getPmtProductListPage4PersonWebServer?sessionkey=%@",HOST,sessionKey]
/**IMEI查询*/
#define URL_SEARCH(sessionKey,imei) [NSString stringWithFormat:@"%@/api/promoter/queryDeviceImeiSimpleInfo?sessionkey=%@&imei=%@",HOST,sessionKey,imei]

#define URL_CONFIG(sessionKey) [NSString stringWithFormat:@"%@/api/clientui/getHomeConfigs?sessionkey=%@",HOST,sessionKey]


#define URL_REALTIME(sessionKey,lastId) [NSString stringWithFormat:@"%@/api/promoter/getRealtimeActivatonData?sessionkey=%@&last_id=%d&size=20",HOST,sessionKey,lastId]



/*******************秒拍***********/

#define URL_ARTICLE(sessionKey,type,page) [NSString stringWithFormat: @"%@/api/article/getPublicArticleList?sessionkey=%@&article_type=%ld&pageindex=%d&pagesize=%d",HOST,sessionKey,type,page,PAGESIZE_VIDEO]
//http://xy.skywalker.19where.com/api/article/getPublicArticleList?pageindex=1&pagesize=20&sessionkey=9aec0f0ce96bffa023ce33a8113f04af&article_type=1
#define URL_VIDEO_HOT(sessionKey,type,page) [NSString stringWithFormat: @"%@/api/article/getPublicArticleListByHot?sessionkey=%@&article_type=%ld&pageindex=%d&pagesize=%d",HOST,sessionKey,type,page,PAGESIZE_VIDEO]

#define URL_VIDEO_ME(sessionKey,type,page) [NSString stringWithFormat: @"%@/api/article/getPublicArticleListByMy?sessionkey=%@&article_type=%ld&pageindex=%d&pagesize=%d",HOST,sessionKey,type,page,PAGESIZE_VIDEO]

/**发布视频*/
#define URL_VIDEO_PUBLISH() [NSString stringWithFormat: @"%@/api/article/publishMovieArticle",HOST]

/**发布图片*/
#define URL_ARTICLE_PUBLISH() [NSString stringWithFormat: @"%@/api/article/publishPictureArticle",HOST]

/**获取评论列表*/
#define URL_ARTICLE_COMMENT(sessionKey,articleId,page) [NSString stringWithFormat: @"%@/api/article/getCommentList?sessionkey=%@&article_id=%d&pageindex=%d&pagesize=%d",HOST,sessionKey,articleId,page,PAGESIZE_VIDEO]

/**评论文章*/
#define URL_PUBLISH_COMMENT() [NSString stringWithFormat: @"%@/api/article/commentArtilce",HOST]
/**文章顶、踩*/
#define URL_ARTICLE_VOTE() [NSString stringWithFormat: @"%@/api/article/voteArticle",HOST]
/**举报文章*/
#define URL_ARTICLE_REPORT() [NSString stringWithFormat: @"%@/api/article/reportArtilce",HOST]

/**举报评论*/
#define URL_COMMENT_REPORT() [NSString stringWithFormat: @"%@/api/article/reportComment",HOST]

/**扫码结果url*/
#define URL_QRCODE_RESULT(sid,qrcode,codeType) [NSString stringWithFormat: @"%@/api/qrcode/getQrcode?sessionkey=%@&qrcode=%@&code_code=%@",HOST,sid,qrcode,codeType]

