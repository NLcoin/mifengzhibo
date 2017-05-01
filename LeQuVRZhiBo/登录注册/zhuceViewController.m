//
//  zhuceViewController.m
//  LeQuVRZhiBo
//
//  Created by lhb on 16/11/14.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "zhuceViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "wanshanViewController.h"
#import "WJGbutton.h"
@interface zhuceViewController ()<UITextFieldDelegate>
{
    NSTimer *timer;
}
@property (nonatomic,strong) UIImageView *logoimage;
@property (nonatomic,strong) UITextField *text1;
@property (nonatomic,strong) UITextField *text2;
@property (nonatomic,strong) UITextField *text3;

@property (nonatomic,strong) UILabel *line1;
@property (nonatomic,strong) UILabel *line2;
@property (nonatomic,strong) UILabel *line3;

@property (nonatomic,strong) UIImageView *left1;
@property (nonatomic,strong) UIImageView *left2;
@property (nonatomic,strong) UIImageView *left3;

@property (nonatomic,strong) UIImageView *backView;
@end

@implementation zhuceViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.backView];
    [self.view addSubview:self.logoimage];
    
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.backView addGestureRecognizer:TapGestureTecognizer];
    
    UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, DEVICE_HEIGHT-130, WIDTH-40, 50*HEIGHT_SCALE)];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [finishBtn setBackgroundColor:RGBColor(205, 71, 111)];
    finishBtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    [finishBtn addTarget:self action:@selector(finishBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
    
    UIButton *leftBtn = [[WJGbutton alloc]initWithFrame:CGRectMake(15, 35, 13, 20)];
    [leftBtn setImage :[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(clickedCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    
    [self.view addSubview:self.text1];
    [self.view addSubview:self.text2];
    [self.view addSubview:self.text3];
    
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
}
-(void)clickedCancelBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)finishBtn:(UIButton *)btn{

    UITextField *text = (id)[self.view viewWithTag:200];
    UITextField *text3 = (id)[self.view viewWithTag:201];
    UITextField *text4 = (id)[self.view viewWithTag:202];

    if ([text.text isEqualToString:@""]) {
        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"请输入手机号" andSelfVC:self];
        
    }else if([text3.text isEqualToString:@""])
    {
        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"密码不能为空" andSelfVC:self];
        
    }
    else if (![text3.text isEqualToString:text4.text])
    {
        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"两次密码不一致" andSelfVC:self];
        
    }
    else
    {
        wanshanViewController *wanshan = [[wanshanViewController alloc]init];
        wanshan.phone = text.text;
        wanshan.password = text3.text;
        wanshan.repassword = text4.text;
        [self.navigationController pushViewController:wanshan animated:YES];
    }
//            }
//            else
//            {
//                [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"验证码不正确" andSelfVC:self];
//                NSLog(@"错误信息:%@",error);
//            }
//        }];
}
-(void)yanzhengCode:(UIButton *)btn{
    UITextField *text = (id)[self.view viewWithTag:200];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:text.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"获取验证码成功" andSelfVC:self];


                                         NSLog(@"获取验证码成功");
                                         timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                 }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)time{
    static int i=60;
    UIButton *btn = (id)[self.view viewWithTag:300];
    btn.enabled = NO;
    [btn setTitle:[NSString stringWithFormat:@"%ds后重试",i] forState:UIControlStateNormal];
    i--;
    if (i==0) {
        [timer invalidate];
        timer = nil;
        btn.enabled = YES;
        [btn setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        i=60;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - getters

-(UIImageView *)logoimage
{
    if(!_logoimage)
    {
        _logoimage = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-50*HEIGHT_SCALE, 40*HEIGHT_SCALE, 100*HEIGHT_SCALE, 100*HEIGHT_SCALE)];
        _logoimage.image = [UIImage imageNamed:@"logo"];
    }
    return _logoimage;
}
-(UITextField *)text1
{
    if(!_text1)
    {
        _text1 = [[UITextField alloc] initWithFrame:CGRectMake(40, 220, DEVICE_WIDTH-80, 50)];
        _text1.placeholder = @"请输入手机号";
        _text1.leftView = self.left1;
        [_text1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _text1.leftViewMode=UITextFieldViewModeAlways;
        _text1.delegate = self;
        _text1.tag = 200;
    }
    return _text1;
}
-(UITextField *)text2
{
    if(!_text2)
    {
        _text2 = [[UITextField alloc] initWithFrame:CGRectMake(40, 275, DEVICE_WIDTH-80, 50)];
        _text2.placeholder = @"密码";
        _text2.leftView = self.left2;
        [_text2 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _text2.leftViewMode=UITextFieldViewModeAlways;
        _text2.delegate = self;
        _text2.tag = 201;
    }
    return _text2;
}
-(UITextField *)text3
{
    if(!_text3)
    {
        _text3 = [[UITextField alloc] initWithFrame:CGRectMake(40, 330, DEVICE_WIDTH-80, 50)];
        _text3.placeholder = @"确认密码";
        _text3.leftView = self.left3;
        [_text3 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _text3.leftViewMode=UITextFieldViewModeAlways;
        _text3.delegate = self;
        _text3.tag = 202;
    }
    return _text3;
}
-(UIImageView *)left1
{
    if(!_left1)
    {
        _left1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 30, 30)];
        _left1.image = [UIImage imageNamed:@"电话"];
    }
    return _left1;
}
-(UIImageView *)left2
{
    if(!_left2)
    {
        _left2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        _left2.image = [UIImage imageNamed:@"密码"];
    }
    return _left2;
}
-(UIImageView *)left3
{
    if(!_left3)
    {
        _left3 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        _left3.image = [UIImage imageNamed:@"确认密码"];
    }
    return _left3;
}
-(UILabel *)line1
{
    if(!_line1)
    {
        _line1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 272, DEVICE_WIDTH-150, 1)];
        _line1.backgroundColor = [UIColor whiteColor];
    }
    return _line1;
}
-(UILabel *)line2
{
    if(!_line2)
    {
        _line2 = [[UILabel alloc]initWithFrame:CGRectMake(70, 322, DEVICE_WIDTH-150, 1)];
        _line2.backgroundColor = [UIColor whiteColor];
    }
    return _line2;
}
-(UILabel *)line3
{
    if(!_line3)
    {
        _line3 = [[UILabel alloc] initWithFrame:CGRectMake(70, 378, DEVICE_WIDTH-150, 1)];
        _line3.backgroundColor = [UIColor whiteColor];
    }
    return _line3;
}
-(UIImageView *)backView
{
    if(!_backView)
    {
        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _backView.image = [UIImage imageNamed:@"注册-背景"];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}
-(void)keyboardHide
{
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
}
@end
