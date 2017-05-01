//
//  jinruzhiboViewController.m
//  LeQuVRZhiBo
//
//  Created by 王俊钢 on 2017/1/2.
//  Copyright © 2017年 lhb. All rights reserved.
//

#import "jinruzhiboViewController.h"

@interface jinruzhiboViewController ()
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UIButton *backbtn;
@property (nonatomic,strong) UIButton *btn01;
@property (nonatomic,strong) UIView *lineview;
@property (nonatomic,strong) UIView *titleview;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;

@property (nonatomic,strong) UILabel *piclabel;
@end

@implementation jinruzhiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgimg];
    [self.view addSubview:self.backbtn];
    [self.view addSubview:self.lineview];
    [self.view addSubview:self.btn01];
    [self.view addSubview:self.titleview];
    
    [self.titleview addSubview:self.label1];
    [self.titleview addSubview:self.label2];
    
    [self.lineview addSubview:self.piclabel];
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

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _bgimg.image = [UIImage imageNamed:@"背景设置密码"];
    }
    return _bgimg;
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

-(UIButton *)btn01
{
    if(!_btn01)
    {
        _btn01 = [[UIButton alloc] initWithFrame:CGRectMake(80*WIDTH_SCALE, DEVICE_HEIGHT-200*HEIGHT_SCALE, DEVICE_WIDTH-160*WIDTH_SCALE, 40*HEIGHT_SCALE)];
        _btn01.backgroundColor = [UIColor wjColorFloat:@"EF4572"];
        [_btn01 setTitleColor:[UIColor whiteColor] forState:normal];
        [_btn01 addTarget:self action:@selector(jinruzhibojian) forControlEvents:UIControlEventTouchUpInside];
        [_btn01 setTitle:@"购买门票" forState:normal];
        _btn01.layer.masksToBounds = YES;
        _btn01.layer.cornerRadius = 20*HEIGHT_SCALE;
    }
    return _btn01;
}

-(UIView *)lineview
{
    if(!_lineview)
    {
        _lineview = [[UIView alloc] initWithFrame:CGRectMake(30, 260, DEVICE_WIDTH-60, 120)];
        _lineview.layer.masksToBounds = YES;
        _lineview.layer.borderWidth = 2;
        _lineview.layer.borderColor = [UIColor whiteColor].CGColor;
        _lineview.layer.cornerRadius = 5;
    }
    return _lineview;
}

-(UIView *)titleview
{
    if(!_titleview)
    {
        _titleview = [[UIView alloc] initWithFrame:CGRectMake(30, 160, DEVICE_WIDTH-60, 80)];
        _titleview.backgroundColor = [UIColor wjColorFloat:@"BCB9BD"];
        _titleview.layer.masksToBounds = YES;
        _titleview.layer.cornerRadius = 15;
    }
    return _titleview;
}

-(UILabel *)label1
{
    if(!_label1)
    {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.titleview.frame.size.width-20, 30)];
        _label1.text = @"购买门票";
        _label1.font = [UIFont systemFontOfSize:13];
        _label1.textColor = [UIColor wjColorFloat:@"EF4572"];
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    return _label1;
}

-(UILabel *)label2
{
    if(!_label2)
    {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleview.frame.size.height/2, self.titleview.frame.size.width-10, 30)];
        _label2.text = @"该主播设置为收费房间，请付费观看";
        _label2.font = [UIFont systemFontOfSize:13];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.textColor = [UIColor whiteColor];
    }
    return _label2;
}

-(UILabel *)piclabel
{
    if(!_piclabel)
    {
        _piclabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.lineview.frame.size.height/2-20, self.lineview.frame.size.width-20, 40)];
        _piclabel.backgroundColor = [UIColor wjColorFloat:@"4F3540"];
        _piclabel.textColor = [UIColor wjColorFloat:@"BCB9BD"];
        _piclabel.text = [NSString stringWithFormat:@"%@星票",_moneyNum];
        _piclabel.layer.masksToBounds = YES;
        _piclabel.layer.cornerRadius = 4;
    }
    return _piclabel;
}

#pragma mark - 实现方法

-(void)backbtnclick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)jinruzhibojian
{
    _btn01.enabled=NO;
    [self payMoney];
}
#pragma mark-
#pragma mark-直播扣费
-(void)payMoney
{
    [AFManager getReqURL:[NSString stringWithFormat:PRIVITE_ROOM_PASSWORD_URL,[USERDEFAULT valueForKey:@"uid"],_AnchorID
                          ] block:^(id infor)
     {
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             [self.navigationController pushViewController:_play animated:YES];
         }else if([[infor objectForKey:@"code"]integerValue]==201)
         {
             [NSObject wj_showHUDWithTip:@"余额不足请去充值"];
         }else{
             [NSObject wj_showHUDWithTip:@"操作失败"];
             
         }
         _btn01.enabled=YES;
     } errorblock:^(NSError *error)
     {
         _btn01.enabled=YES;
     }];
}
@end
