//
//  shezhimimaViewController.m
//  LeQuVRZhiBo
//
//  Created by 王俊钢 on 2017/1/1.
//  Copyright © 2017年 lhb. All rights reserved.
//

#import "shezhimimaViewController.h"
#import "setView.h"

#import "livingViewController.h"
@interface shezhimimaViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIButton *backbtn;

@property (nonatomic,strong) setView *setView;


@end

@implementation shezhimimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.bgImg addGestureRecognizer:TapGestureTecognizer];
    
    [self.view addSubview:self.bgImg];
    [self.view addSubview:self.backbtn];
    [self.view addSubview:self.setView];
    [self.view addSubview:self.submitBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    
    
}

#pragma mark - getters

-(UIImageView *)bgImg
{
    if(!_bgImg)
    {
        _bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _bgImg.image = [UIImage imageNamed:@"背景设置密码"];
        _bgImg.userInteractionEnabled = YES;
    }
    return _bgImg;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, DEVICE_HEIGHT-180, DEVICE_WIDTH-120, 40)];
        [_submitBtn setTitle:@"发起直播" forState:normal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [UIColor wjColorFloat:@"EF4573"];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        [_submitBtn addTarget:self action:@selector(submitbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(UIButton *)backbtn
{
    if(!_backbtn)
    {
        _backbtn = [[UIButton alloc] initWithFrame:CGRectMake(DEVICE_WIDTH-70*WIDTH_SCALE, 80*HEIGHT_SCALE, 30*WIDTH_SCALE, 30*HEIGHT_SCALE)];
        [_backbtn setImage:[UIImage imageNamed:@"房间直播_10"] forState:normal];
        [_backbtn addTarget:self action:@selector(backbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backbtn;
}

-(setView *)setView
{
    if(!_setView)
    {
        _setView = [[setView alloc] initWithFrame:CGRectMake(30*WIDTH_SCALE, 150*HEIGHT_SCALE, DEVICE_WIDTH-60*WIDTH_SCALE, 200*HEIGHT_SCALE)];
        _setView.layer.masksToBounds = YES;
        _setView.layer.borderWidth = 2;
        _setView.layer.borderColor = [UIColor whiteColor].CGColor;
        _setView.layer.cornerRadius = 10;
        _setView.text1.delegate = self;
        _setView.text1.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _setView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide
{
    [self.setView.text1 resignFirstResponder];

}
#pragma mark - 实现方法

-(void)submitbtnclick:(UIButton *)btn
{
    if ([_setView.text1.text intValue]>500) {
        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"星票数量不能多于500" andSelfVC:self];

    }else if ([_setView.text1.text intValue]<=0) {
        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"星票数量不能少于0" andSelfVC:self];
        
    }else{
        btn.enabled = NO;
        UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        testActivityIndicator.center = CGPointMake(WIDTH/2, HEIGHT/2);//只能设置中心，不能设置大小
        testActivityIndicator.frame = CGRectMake(WIDTH/2-50, HEIGHT/2-80, 100, 100);//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
        [self.view addSubview:testActivityIndicator];
        testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
        [testActivityIndicator startAnimating]; // 开始旋转
        [AFManager postReqURL:ZHIBOKAISHI reqBody:@{@"uid":[USERDEFAULT valueForKey:@"uid"],@"type":self.type,@"area":[USERDEFAULT valueForKey:@"cityName"],@"money":_setView.text1.text} block:^(id inforsss) {
            NSLog(@"=========%@=========",inforsss);
            
            if ([[NSString stringWithFormat:@"%@",inforsss[@"code"]] isEqualToString:@"200"]) {
                [AFManager postReqURL:CHATID reqBody:@{@"id":[USERDEFAULT valueForKey:@"uid"],@"name":self.name} block:^(id infor) {
                    NSLog(@"-%@-",infor);
                    if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"]) {
                        
                        [AFManager postReqURL:CHAXUNLIAOTIANSHI reqBody:@{@"id":[USERDEFAULT valueForKey:@"uid"]} block:^(id infors) {
                            NSLog(@"-%@--",infors);
                            if ([[NSString stringWithFormat:@"%@",infors[@"code"]] isEqualToString:@"200"]) {
                                [testActivityIndicator stopAnimating]; // 结束旋转
                                [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
                                livingViewController *live = [[livingViewController alloc]init];
                                live.liveid = inforsss[@"data"][@"tl_address"];
                                live.starttime = inforsss[@"data"][@"starttime"];
                                live.startID=inforsss[@"data"][@"id"];
                                //live.chatId = infors[@"chatRooms"][0][@"chrmId"];
                                live.chatId =[USERDEFAULT valueForKey:@"uid"];
                                [self.navigationController pushViewController:live animated:YES];
                            }
                        }];
                        
                    }else{
                        btn.enabled = YES;
                        [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"聊天室创建失败" andSelfVC:self];
                        [testActivityIndicator stopAnimating]; // 结束旋转
                        [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
                    }
                    
                }];
                
            }else{
                btn.enabled = YES;
                [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"开播失败" andSelfVC:self];
                [testActivityIndicator stopAnimating]; // 结束旋转
                [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
            }
            
        }];
    }
    

}

-(void)backbtnclick
{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
