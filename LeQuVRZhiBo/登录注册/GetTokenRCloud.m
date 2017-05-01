//
//  GetTokenRCloud.m
//  LeQuVRZhiBo
//
//  Created by 李壮 on 2016/12/31.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import "GetTokenRCloud.h"
#import <CommonCrypto/CommonCrypto.h>
#define RONGCLOUD_IM_APPKEY @"mgb7ka1nm3jwg"
#define RONGCLOUD_IM_APPSECRET @"7Sdm6racxt"

@implementation GetTokenRCloud
static GetTokenRCloud*getToken;
+(instancetype)sharedMSTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        getToken=[[GetTokenRCloud alloc]init];
    });
    return getToken;
}
//获取随机数
-(NSString *)getRandomNonce
{
    NSInteger randomValue = [self getRandomNumber:100000 to:999999];
    return  [NSString stringWithFormat:@"%ld",randomValue];
}
//获取时间戳 从1970年
-(NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval times =  [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",times];
}

//获取从 from 到  to 的随机数
-(NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

//sha1 加密
-(NSString *)sha1WithKey:(NSString *)key
{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

//根据appSecret nonce timestamp 获取signature
-(NSString *)getSignatureWithAppSecret:(NSString *)appSecret nonce:(NSString *)nonce timestamp:(NSString *)timestamp
{
    NSString *sha1String = [NSString stringWithFormat:@"%@%@%@",appSecret,nonce,timestamp];
    return [self sha1WithKey:sha1String];
}
+(void)getToken:(NSString*)uid name:(NSString*)name headImageUrl:(NSString*)headUrl block:(void(^)(id infor))callBack
{
    //获取Token的接口
    NSString*url = @"https://api.cn.ronghub.com/user/getToken.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    
    NSDictionary *dict = @{@"userId":uid,@"name":name,@"portraiUri":headUrl};
    
    NSString *appkey = RONGCLOUD_IM_APPKEY;
    NSString *nonce = [[GetTokenRCloud sharedMSTool] getRandomNonce];
    NSString *timestamp = [[GetTokenRCloud sharedMSTool] getTimestamp];
    NSString *signature = [[GetTokenRCloud  sharedMSTool]getSignatureWithAppSecret:RONGCLOUD_IM_APPSECRET nonce:nonce timestamp:timestamp];
    
    NSLog(@"%@",appkey);
    NSLog(@"%@",nonce);
    NSLog(@"%@",timestamp);
    NSLog(@"%@",signature);
//设置请求头
    [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
//调用POST方法
    [manager POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        callBack(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
