//
//  UMeng.m
//  杨天赐的个人项目
//
//  Created by yang on 2017/2/9.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "UMeng.h"

@interface UMeng ()



@end

@implementation UMeng


/**
 三方分享
 */

#pragma mark - ---------- 初始配置 ----------

-(void)StartShare{
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58982aad99f0c73858000e8c"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];

    
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}



#pragma mark - ---------- 分享功能实现 ----------
-(void)UShareWithPlatform:(UMSocialPlatformType)platformType Success:(void (^)(NSError *))success Fail:(void (^)(id))fail{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"杨天赐-友盟分享" descr:@"进行了初步集成,包含QQ等基础应用分享" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            fail(error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
//                success(resp);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
                success(data);
            }
        }
    }];
    
}

#pragma mark - ---------- 友盟三方登录 ----------
//auth
-(void)getUserInfoForPlatform:(UMSocialPlatformType)platformType Success:(void (^)(NSError *))success Fail:(void (^)(id))fail{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        
        if (error) {
            fail(error);
        }else{
            success(result);
        }
        
    }];
    
}


    
    
#pragma mark 友盟统计
    
-(void)StartStatistics{
    
    UMConfigInstance.appKey = @"58982aad99f0c73858000e8c";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.ePolicy = REALTIME;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
}
    
    






@end
