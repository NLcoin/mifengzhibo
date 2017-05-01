//
//  dengluViewController.m
//  LeQuVRZhiBo
//
//  Created by lhb on 16/11/14.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "dengluViewController.h"
#import "zhuceViewController.h"
#import "forgetViewController.h"
#import <ShareSDK/ShareSDK.h>

#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "GetTokenRCloud.h"
#import "leftView0.h"
#import "leftView1.h"
@interface dengluViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *backimg;
@property (nonatomic,strong) UIImageView *logoimage;
@property (nonatomic,strong) UITextField *text1;
@property (nonatomic,strong) UITextField *text2;

@property (nonatomic,strong) leftView0 *leftview0;
@property (nonatomic,strong) leftView1 *leftview1;

@property (nonatomic,strong) UILabel *line0;
@property (nonatomic,strong) UILabel *line1;
@end

@implementation dengluViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [GetTokenRCloud sharedMSTool];
    
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.backimg addGestureRecognizer:TapGestureTecognizer];
    [self.view addSubview:self.backimg];
    [self.view addSubview:self.logoimage];
    [self.view addSubview:self.leftview0];
    [self.view addSubview:self.leftview1];
    
    [self.view addSubview:self.text1];
    [self.view addSubview:self.text2];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.line1];
    UIButton *forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-80, 110+542.f/750.f*WIDTH, 60, 20)];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithWhite:0.7 alpha:1] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBtn addTarget:self action:@selector(forgetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    
    UIButton *dengluBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 140+542.f/750.f*WIDTH, WIDTH-40, 40)];
    [dengluBtn setTitle:@"完成" forState:UIControlStateNormal];
    [dengluBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dengluBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [dengluBtn setBackgroundColor:RGBColor(203, 70, 111)];
    dengluBtn.layer.cornerRadius = 20;
    [dengluBtn addTarget:self action:@selector(dengluBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dengluBtn];
    
    UIButton *weiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-140, 190+542.f/750.f*WIDTH, 30, 30)];
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"个人-个人信息_07"] forState:UIControlStateNormal];
    
    weiboBtn.layer.cornerRadius = 15;
    [weiboBtn addTarget:self action:@selector(weiboBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:weiboBtn];
    
    UIButton *QQbtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-100, 190+542.f/750.f*WIDTH, 30, 30)];
    [QQbtn setBackgroundImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    
    QQbtn.layer.cornerRadius = 15;
    [QQbtn addTarget:self action:@selector(QQbtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:QQbtn];
    
    UIButton *weixinBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60, 190+542.f/750.f*WIDTH, 30, 30)];
    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"微信呢"] forState:UIControlStateNormal];
    
    weixinBtn.layer.cornerRadius = 15;
    [weixinBtn addTarget:self action:@selector(weixinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weixinBtn];
    
    UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, HEIGHT-60, WIDTH-40, 40)];
    [phoneBtn setTitle:@"手机号注册>>" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor colorWithWhite:0.7 alpha:1] forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [phoneBtn addTarget:self action:@selector(phoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneBtn];

}
-(void)phoneBtn:(UIButton *)btn{
    zhuceViewController *zhuce = [[zhuceViewController alloc]init];
    [self.navigationController pushViewController:zhuce animated:YES];
}
-(void)QQbtn:(UIButton *)btn{
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"%@",user);
             NSLog(@"uid=%@",user.uid);
             NSLog(@"--%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSLog(@"class=%@",[user.credential.token class]);
             
             NSDictionary *dic = @{@"dsf":@"1",@"nickname":user.nickname,@"head_pic":user.icon,@"dsftoken":[NSString stringWithFormat:@"%@",user.uid]};
             [AFManager postReqURL:THIRDLOGIN reqBody:dic block:^(id infor) {
                 NSLog(@"%@",infor);
                 if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                     [USERDEFAULT setValue:infor[@"data"][@"id"] forKey:@"uid"];
                     [USERDEFAULT setValue:infor[@"data"][@"nickname"] forKey:@"nickname"];
                     [USERDEFAULT setValue:infor[@"data"][@"head_pic"] forKey:@"imgUrl"];
                     [USERDEFAULT setValue:infor[@"data"][@"account"] forKey:@"account"];
                     [USERDEFAULT synchronize];
                     [AFManager getReqURL:[NSString stringWithFormat:@"%@?id=%@",TOKEN,infor[@"data"][@"id"]] block:^(id infor) {
                         if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                             [USERDEFAULT setValue:infor[@"token"] forKey:@"token"];
                             [USERDEFAULT synchronize];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];

                         }
                     } errorblock:^(NSError *error) {
                         
                     }];
                    
                 }
                 
             }];
             NSLog(@"55--%@",dic);
             //在这里面实现app界面的跳转：
             //1.如果用户将qq和app已经进行了绑定，直接登录成功就能拿到用户的数据；
             //2.如果用户没有将qq和app进行绑定，那么绑定成功后就会从服务器获取到token，这个token是用来获取用户数据的，很重要。
             //总之：每一个用户都有自己唯一的标识，使用第三方登录，第三方是不知道用户的账号和密码的，那么用户必须先绑定，绑定成功后，服务器返回这个标识，之后服务器通过这个标识才能获取到用户的数据。
         } else {
             NSLog(@"%@",error);
         }
     }];
    

}
-(void)weixinBtn:(UIButton *)btn{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"%@",user);
             NSLog(@"uid=%@",user.uid);
             NSLog(@"--%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             
             NSDictionary *dic = @{@"dsf":@"2",@"nickname":user.nickname,@"head_pic":user.icon,@"dsftoken":[NSString stringWithFormat:@"%@",user.uid]};
             [AFManager postReqURL:THIRDLOGIN reqBody:dic block:^(id infor) {
                 NSLog(@"%@",infor);
                 if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                     [USERDEFAULT setValue:infor[@"data"][@"id"] forKey:@"uid"];
                     [USERDEFAULT setValue:infor[@"data"][@"nickname"] forKey:@"nickname"];
                     [USERDEFAULT setValue:infor[@"data"][@"head_pic"] forKey:@"imgUrl"];
                     [USERDEFAULT setValue:infor[@"data"][@"account"] forKey:@"account"];
                     [USERDEFAULT synchronize];
                     [AFManager getReqURL:[NSString stringWithFormat:@"%@?id=%@",TOKEN,infor[@"data"][@"id"]] block:^(id infor) {
                         if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                             [USERDEFAULT setValue:infor[@"token"] forKey:@"token"];
                             [USERDEFAULT synchronize];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
                             
                         }
                     } errorblock:^(NSError *error) {
                         
                     }];
                     
                 }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"201"]) {
                     [USERDEFAULT setValue:infor[@"data"][@"id"] forKey:@"uid"];
                     [USERDEFAULT setValue:infor[@"data"][@"nickname"] forKey:@"nickname"];
                     [USERDEFAULT setValue:infor[@"data"][@"head_pic"] forKey:@"imgUrl"];
                     [USERDEFAULT setValue:infor[@"data"][@"account"] forKey:@"account"];
                     [USERDEFAULT synchronize];
                     [AFManager getReqURL:[NSString stringWithFormat:@"%@?id=%@",TOKEN,infor[@"data"][@"id"]] block:^(id infor) {
                         if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                             [USERDEFAULT setValue:infor[@"token"] forKey:@"token"];
                             [USERDEFAULT synchronize];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
                             
                         }
                     } errorblock:^(NSError *error) {
                         
                     }];
                     
                 }
                 
             }];

             //在这里面实现app界面的跳转：
             //1.如果用户将qq和app已经进行了绑定，直接登录成功就能拿到用户的数据；
             //2.如果用户没有将qq和app进行绑定，那么绑定成功后就会从服务器获取到token，这个token是用来获取用户数据的，很重要。
             //总之：每一个用户都有自己唯一的标识，使用第三方登录，第三方是不知道用户的账号和密码的，那么用户必须先绑定，绑定成功后，服务器返回这个标识，之后服务器通过这个标识才能获取到用户的数据。
         } else {
             NSLog(@"%@",error);
         }
     }];
}
-(void)weiboBtn:(UIButton *)btn{
    //例如新浪的登录
    
    
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSDictionary *dic = @{@"dsf":@"3",@"nickname":user.nickname,@"head_pic":user.icon,@"dsftoken":[NSString stringWithFormat:@"%@",user.uid]};
             [AFManager postReqURL:THIRDLOGIN reqBody:dic block:^(id infor) {
                 NSLog(@"%@",infor);
                 if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                     [USERDEFAULT setValue:infor[@"data"][@"id"] forKey:@"uid"];
                     [USERDEFAULT setValue:infor[@"data"][@"nickname"] forKey:@"nickname"];
                     [USERDEFAULT setValue:infor[@"data"][@"head_pic"] forKey:@"imgUrl"];
                     [USERDEFAULT setValue:infor[@"data"][@"account"] forKey:@"account"];
                     [USERDEFAULT synchronize];
                     [AFManager getReqURL:[NSString stringWithFormat:@"%@?id=%@",TOKEN,infor[@"data"][@"id"]] block:^(id infor) {
                         if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                             [USERDEFAULT setValue:infor[@"token"] forKey:@"token"];
                             [USERDEFAULT synchronize];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];

                         }
                     } errorblock:^(NSError *error) {
                         
                     }];
                     
                    
                 }
                 
             }];

             //在这里面实现app界面的跳转：
             //1.如果用户将qq和app已经进行了绑定，直接登录成功就能拿到用户的数据；
             //2.如果用户没有将qq和app进行绑定，那么绑定成功后就会从服务器获取到token，这个token是用来获取用户数据的，很重要。
             //总之：每一个用户都有自己唯一的标识，使用第三方登录，第三方是不知道用户的账号和密码的，那么用户必须先绑定，绑定成功后，服务器返回这个标识，之后服务器通过这个标识才能获取到用户的数据。
         } else {
             NSLog(@"%@",error);
         }
     }];

}
-(void)forgetBtn:(UIButton *)btn{
    forgetViewController *zhuce = [[forgetViewController alloc]init];
    [self.navigationController pushViewController:zhuce animated:YES];
}
-(void)dengluBtn:(UIButton *)btn{
    
    UITextField *text = (id)[self.view viewWithTag:200];
    UITextField *text2 = (id)[self.view viewWithTag:201];
    if ([text.text isEqualToString:@""]) {
        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"请输入账号" andSelfVC:self];
        
    }else if ([text2.text isEqualToString:@""]){
        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"请输入密码" andSelfVC:self];
    }else if (![text2.text isEqualToString:@""]&&![text.text isEqualToString:@""]){
        
        NSDictionary *dic = @{@"phone":text.text,@"password":text2.text};
        [AFManager postReqURL:LOGIN reqBody:dic block:^(id infor) {
            if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                [USERDEFAULT setValue:infor[@"id"] forKey:@"uid"];
                [USERDEFAULT setValue:infor[@"nickname"] forKey:@"nickname"];
                [USERDEFAULT setValue:infor[@"head_pic"] forKey:@"imgUrl"];
                [USERDEFAULT setValue:infor[@"account"] forKey:@"account"];
                [USERDEFAULT synchronize];
                NSString *uid = [infor objectForKey:@"id"];
                
                
                [AFManager getReqURL:[NSString stringWithFormat:@"%@?id=%@",TOKEN,uid] block:^(id infors) {
                    if ([[NSString stringWithFormat:@"%@",infors[@"code"]] isEqualToString:@"200"]) {
                        [USERDEFAULT setValue:infors[@"token"] forKey:@"token"];
                        [USERDEFAULT synchronize];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
                        
                    }
                } errorblock:^(NSError *error) {
                    
                }];
                
                
            }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"201"]){
                [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"用户名错误" andSelfVC:self];
            }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"202"]){
                [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"密码错误" andSelfVC:self];
            }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"203"]){
                [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"已被封号" andSelfVC:self];
            }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"204"]){
                [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"已登录" andSelfVC:self];
            }
            
            
        }];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getters


-(UIImageView *)backimg
{
    if(!_backimg)
    {
        _backimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _backimg.image = [UIImage imageNamed:@"背景33"];
        _backimg.userInteractionEnabled = YES;
    }
    return _backimg;
}

-(UIImageView *)logoimage
{
    if(!_logoimage)
    {
        _logoimage = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-50*HEIGHT_SCALE, 40*HEIGHT_SCALE, 100*HEIGHT_SCALE, 100*HEIGHT_SCALE)];
        _logoimage.image = [UIImage imageNamed:@"logo"];
    }
    return _logoimage;
}

-(leftView0 *)leftview0
{
    if(!_leftview0)
    {
        _leftview0 = [[leftView0 alloc] initWithFrame:CGRectMake(40, 220, 80, 40)];
        
    }
    return _leftview0;
}


-(leftView1 *)leftview1
{
    if(!_leftview1)
    {
        _leftview1 = [[leftView1 alloc] initWithFrame:CGRectMake(40, 280, 80, 40)];
        
    }
    return _leftview1;
}


-(UITextField *)text1
{
    if(!_text1)
    {
        _text1 = [[UITextField alloc] initWithFrame:CGRectMake(120, 220, DEVICE_WIDTH/2, 40)];
        _text1.delegate = self;
        _text1.placeholder = @"请输入手机号";
        [_text1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _text1.tag = 200;
    }
    return _text1;
}

-(UITextField *)text2
{
    if(!_text2)
    {
        _text2 = [[UITextField alloc] initWithFrame:CGRectMake(120, 280, DEVICE_WIDTH/2, 40)];
        _text2.delegate = self;
        _text2.placeholder = @"请输入密码";
        _text2.secureTextEntry = YES;
        [_text2 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _text2.tag = 201;
    }
    return _text2;
}

-(UILabel *)line0
{
    if(!_line0)
    {
        _line0 = [[UILabel alloc] initWithFrame:CGRectMake(120, 260, DEVICE_WIDTH/2, 1)];
        _line0.backgroundColor = [UIColor whiteColor];
    }
    return _line0;
}

-(UILabel *)line1
{
    if(!_line1)
    {
        _line1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 320, DEVICE_WIDTH/2, 1)];
        _line1.backgroundColor = [UIColor whiteColor];
    }
    return _line1;
}

-(void)keyboardHide
{
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
}


@end
