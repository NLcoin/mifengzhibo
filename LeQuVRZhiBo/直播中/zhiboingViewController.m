//
//  zhiboingViewController.m
//  LeQuVRZhiBo
//
//  Created by lhb on 16/11/7.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "zhiboingViewController.h"
#import "livingViewController.h"
#import "typeViewController.h"
#import "shezhimimaViewController.h"
@interface zhiboingViewController ()<UITextFieldDelegate>
{
    NSString *chatId;
    NSString *targetId;
    UIButton *addBtn;
    UITextField *title;
}
@property (nonatomic,strong) UIButton *setmimabtn;
@end

@implementation zhiboingViewController
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
-(void)type:(id)user{
    [addBtn setTitle:[user userInfo][@"type"] forState:UIControlStateNormal];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(type:) name:@"zhibotype" object:nil];
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backView.image = [UIImage imageNamed:@"未直播"];
    [self.view addSubview:backView];
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-30, HEIGHT-30, 15, 15)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"未直播_10"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    title = [[UITextField alloc]initWithFrame:CGRectMake(0, 150, WIDTH, 40)];
    title.text = @"写个标题吧!";
    title.tag = 200;
    title.delegate = self;
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    
    UIButton *biaoqianBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-30-50-20, 200, 15, 15)];
    [biaoqianBtn setBackgroundImage:[UIImage imageNamed:@"未直播_03"] forState:UIControlStateNormal];
    [self.view addSubview:biaoqianBtn];
    
    addBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-30-50, 200, 50, 15)];
    [addBtn setTitle:@"添加标签" forState:UIControlStateNormal];
    addBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [addBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIButton *cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2+30, 200, 15, 15)];
    [cityBtn setBackgroundImage:[UIImage imageNamed:@"未直播_05"] forState:UIControlStateNormal];
    [self.view addSubview:cityBtn];
    UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+30+20, 200, 100, 15)];
    rightLable.text = [USERDEFAULT valueForKey:@"cityName"];
    rightLable.font = [UIFont systemFontOfSize:12];
    rightLable.textColor = [UIColor whiteColor];
    rightLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:rightLable];
    
    UIButton *liveBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 250, WIDTH/2, 40)];
    [liveBtn setTitle:@"马上开播" forState:UIControlStateNormal];
    [liveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [liveBtn setBackgroundColor:[UIColor clearColor]];
    liveBtn.layer.borderWidth = 2;
    liveBtn.layer.borderColor = [[UIColor redColor]CGColor];
    liveBtn.layer.cornerRadius = 20;
    liveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [liveBtn addTarget:self action:@selector(liveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:liveBtn];
    
    [self.view addSubview:self.setmimabtn];
    
       
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    textField.text = @"";
}
-(void)addBtn{
    typeViewController *live = [[typeViewController alloc]init];
    [self.navigationController pushViewController:live animated:YES];
}
-(void)liveBtn:(UIButton *)btn{
    btn.enabled = NO;
    UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    testActivityIndicator.center = CGPointMake(WIDTH/2, HEIGHT/2);//只能设置中心，不能设置大小
    testActivityIndicator.frame = CGRectMake(WIDTH/2-50, HEIGHT/2-80, 100, 100);//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
    [self.view addSubview:testActivityIndicator];
    testActivityIndicator.color = [UIColor redColor]; // 改变圈圈的颜色为红色； iOS5引入
    [testActivityIndicator startAnimating]; // 开始旋转
    [AFManager postReqURL:ZHIBOKAISHI reqBody:@{@"uid":[USERDEFAULT valueForKey:@"uid"],@"type":addBtn.titleLabel.text,@"area":[USERDEFAULT valueForKey:@"cityName"]} block:^(id inforsss) {
        NSLog(@"=========%@=========",inforsss);
        
        if ([[NSString stringWithFormat:@"%@",inforsss[@"code"]] isEqualToString:@"200"]) {
            [AFManager postReqURL:CHATID reqBody:@{@"id":[USERDEFAULT valueForKey:@"uid"],@"name":title.text} block:^(id infor) {
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UIButton *)setmimabtn
{
    if(!_setmimabtn)
    {
        _setmimabtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 250, 100, 40)];
        [_setmimabtn setTitle:@"私密设置" forState:normal];
        [_setmimabtn addTarget:self action:@selector(setmimabtnclick) forControlEvents:UIControlEventTouchUpInside];
        _setmimabtn.layer.masksToBounds = YES;
        _setmimabtn.layer.cornerRadius = 20;
        _setmimabtn.layer.borderColor = [UIColor redColor].CGColor;
        _setmimabtn.backgroundColor = [UIColor clearColor];
        [_setmimabtn setTitleColor:[UIColor redColor] forState:normal];
        _setmimabtn.layer.borderWidth = 2;
        _setmimabtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _setmimabtn;
}

-(void)setmimabtnclick
{
    NSLog(@"设置密码设置");
    shezhimimaViewController *shezhiVC = [[shezhimimaViewController alloc] init];
    shezhiVC.name = title.text;
    shezhiVC.type = addBtn.titleLabel.text;
    [self.navigationController pushViewController:shezhiVC animated:YES];
}

@end
