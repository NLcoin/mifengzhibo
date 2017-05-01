//
//  HeaderPath.h
//  LeQuVRZhiBo
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 lhb. All rights reserved.
//

#ifndef HeaderPath_h
#define HeaderPath_h


#endif /* HeaderPath_h */
//登录
#define LOGIN @"http://103.40.102.84/funlive/index.php/Admin/Apilive/login"
//注册
#define ZHUCE @"http://103.40.102.84/funlive/index.php/Admin/Apilive/register"
//反馈
#define FANKUI @"http://103.40.102.84/funlive/index.php/Admin/Apilive/feedback"
//上传个人信息
#define USERINFO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uInfo"
//上传头像
#define UPPICTURE @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uPicIos"
//修改个人信息
#define CHANGEINFO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uUpdate"
//注销
#define ZHUXIAO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/logOut?id=%@"
//修改密码
#define CHANGEMIMA @"http://103.40.102.84/funlive/index.php/Admin/Apilive/pUpdate"
//忘记密码
#define FORGETMIMA @"http://103.40.102.84/funlive/index.php/Admin/Apilive/pForget"
//个人主页
#define GERENZHUYE @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uShow?id=%@"
//举报
#define JUBAO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/report"
//主播认证
#define ZHUBORENZHENG @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uAuth"
//首页主播列表接口
#define SHOUYEZHUBO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uList?id=%@"
//热门主播列表接口
#define HOTZHUBO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uListhot?id=%@"
//附近主播列表接口
#define NEARZHUBO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/uNear?id=%@&lat=%@&lng=%@"
//系统消息接口
#define XITONGXIAOXI @"http://103.40.102.84/funlive/index.php/Admin/Apilive/sysMess"

//发布动态接口（IOS）有图
#define FABUDONGTAI @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynIospic"
//无图
#define FABUDONGTAI2 @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynIoscontent"

//动态列表接口
#define DONGTAILIST @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynList"
//动态删除接口
#define SHANCHUDONGTAI @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynDel?id=%@&uid=%@"
//动态-发表评论接口
#define FABIAOPINGLUN @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynDel"
//动态-评论列表接口
#define PINGLUNLIEBIAO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynCommetlist"
//动态-评论删除接口
#define SHANCHUPINGLUN @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynCommetdel"
//添加关注接口
#define ADDGUANZHU @"http://103.40.102.84/funlive/index.php/Admin/Apilive/fansAdd?fansid=%@&uid=%@"
//取消关注接口
#define DELGUANZHU @"http://103.40.102.84/funlive/index.php/Admin/Apilive/fansDel?fansid=%@&uid=%@"
//关注的人列表接口
#define GUANZHULIST @"http://103.40.102.84/funlive/index.php/Admin/Apilive/gzList?fansid=%@&page=%ld&num=15"
//被关注的人列表接口
#define FENSILIST @"http://103.40.102.84/funlive/index.php/Admin/Apilive/bgzList?uid=%@&page=%ld&num=15"
//社区
#define SHEQU @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynNearlist?id=%@&lat=%@&lng=%@&page=%ld&num=15"
//点赞
#define DIANZAN @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynZan"
//直播开始接口
#define ZHIBOKAISHI @"http://103.40.102.84/funlive/index.php/Admin/Apilive/liveStart"
//直播结束接口
#define JIESHUZHIBO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/liveStop"
//获取融云token
#define TOKEN @"http://103.40.102.84/funlive/index.php/Admin/Apilive/getTokens"

//第三方登录接口
#define THIRDLOGIN @"http://103.40.102.84/funlive/index.php/Admin/Apilive/sLogin"
//创建聊天室
#define CHATID @"http://103.40.102.84/funlive/index.php/Rong/ltsCreate"
//查询聊天室
#define CHAXUNLIAOTIANSHI @"http://139.224.43.42/funlive/index.php/Rong/ltsQuery"
//销毁聊天室
#define XIAOHUILIAOTIANSHI @"http://103.40.102.84/funlive/index.php/Rong/ltsDestroy"
//创建订单
#define ORDER @"http://103.40.102.84/funlive/index.php/Admin/Apilive/orderID"
//支付宝支付
#define ZHIFUBAO @"http://103.40.102.84/funlive/index.php/Admin/Apilive/alipay"
//微信支付
#define WEIXINZHIFU @"http://103.40.102.84/funlive/index.php/Admin/Wxpay/wxpay"
//我的相册
#define XIANGCE @"http://103.40.102.84/funlive/index.php/ApiliveTwo/Mypic"
//相册上传图片IOS
#define UPIOS @"http://103.40.102.84/funlive/index.php/ApiliveTwo/UploadIos"
//删除相册照片
#define DELPIC @"http://103.40.102.84/funlive/index.php/ApiliveTwo/Delpic"
//添加照片到相册
#define ADDPIC @"http://103.40.102.84/funlive/index.php/ApiliveTwo/Addpic"
//魅力排行
#define MEILI @"http://103.40.102.84/funlive/index.php/admin/ApiliveThree/charm"
//土豪排行
#define TUHAO @"http://103.40.102.84/funlive/index.php/admin/ApiliveThree/money"
//通过uid获取用户信息
#define YOMGHUXINXI @"http://103.40.102.84/funlive/index.php/Rong/headNick"
//我的收益
#define SHOUYI @"http://103.40.102.84/funlive/index.php/Admin/Apilive/syShow"
//充值记录
#define CHONGZHILIST @"http://103.40.102.84/funlive/index.php/Admin/Apilive/recordcz"
//提现记录
#define TIXIANJILU @"http://103.40.102.84/funlive/index.php/ApiliveTwo/Myrecord"
//提现
#define TIXIAN @"http://103.40.102.84/funlive/index.php/ApiliveTwo/withdrawal"
//关注的人统计
#define GUANZHURENSHU @"http://103.40.102.84/funlive/index.php/Admin/Apilive/gzCount?fansid=%@"
//被关注的人
#define BEIGUANZHURENSHU @"http://103.40.102.84/funlive/index.php/Admin/Apilive/bgzCount?uid=%@"
//动态统计
#define DONGTAISHULIANG @"http://103.40.102.84/funlive/index.php/Admin/Apilive/dynCount?uid=%@"
//我的余额
#define YUE @"http://103.40.102.84/funlive/index.php/Admin/Apilive/balanceXp"

//搜索前
#define SOUSUOQIAN @"http://103.40.102.84/funlive/index.php/admin/ApiliveThree/show"
//搜索后
#define SOUSUOHOU @"http://103.40.102.84/funlive/index.php/admin/ApiliveThree/seek"
//用户等级
#define USERLEVEL @"http://103.40.102.84/funlive/index.php/admin/ApiliveThree/vcount"
//直播分类
#define ZHIBOTYPE @"http://103.40.102.84/funlive/index.php/ApiliveTwo/livetype"
//更多
#define MOREZHUBO @"http://103.40.102.84/funlive/index.php/ApiliveTwo/more"
//实名认证
#define RENZHENG @"http://103.40.102.84/funlive/index.php/Zheng/zheng"
