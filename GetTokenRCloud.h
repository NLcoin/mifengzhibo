//
//  GetTokenRCloud.h
//  LeQuVRZhiBo
//
//  Created by 李壮 on 2016/12/31.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTokenRCloud : NSObject
+(instancetype)sharedMSTool;
-(void)getToken:(NSString*)uid name:(NSString*)name headImageUrl:(NSString*)headUrl block:(void(^)(id infor))callBack;
@end
