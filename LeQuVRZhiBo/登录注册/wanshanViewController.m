//
//  wanshanViewController.m
//  LeQuVRZhiBo
//
//  Created by lhb on 16/11/17.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "wanshanViewController.h"
#import "cityViewController.h"
#import "AFHTTPSessionManager.h"
#import "wanshanView.h"
#import "NSObject+MBProgressHUD.h"
@interface wanshanViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIImageView *imageView;
    UITextField *field;
    NSString *sex;
    UILabel *cityLable;
    NSMutableArray *array;
    MBProgressHUD*MB;
}
@property(nonatomic,copy)NSString *uploadImageUrl;

@property (nonatomic,strong) wanshanView *wanshanview;
@property (nonatomic,strong) UIImageView *xinbieimg;
@property (nonatomic,strong) UIImageView *nickimg;
@property (nonatomic,strong) UIImageView *addimg;
@end

@implementation wanshanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}
-(void)city:(id)user{
    cityLable.text = [user userInfo][@"city"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"填写信息";
    [self CustomBackButton];
    sex = @"1";
    array = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(city:) name:@"city" object:nil];

    NSDictionary *dict2 = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict2;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"11"]forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.wanshanview];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(15*WIDTH_SCALE, 10*HEIGHT_SCALE+50*HEIGHT_SCALE, self.view.frame.size.width - 30*WIDTH_SCALE, 20*HEIGHT_SCALE)];
    leftLable.text = @"头像";
    leftLable.textColor = [UIColor whiteColor];
   // leftLable.backgroundColor = [UIColor whiteColor];
    //leftLable.textColor = RGBColor(69, 69, 69);
    leftLable.font = [UIFont systemFontOfSize:14];
    leftLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLable];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-80/2, 30*HEIGHT_SCALE+50*HEIGHT_SCALE, 80*WIDTH_SCALE, 80*HEIGHT_SCALE)];
    imageView.image = [UIImage imageNamed:@"填写信息_033"];
    imageView.layer.cornerRadius = 40;
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(image)];
    [imageView addGestureRecognizer:tap];
    [self.view addSubview:imageView];
    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 130+50, self.view.frame.size.width, 2)];
//    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    //[self.view addSubview:lineView];
    
    UILabel *leftLable2 = [[UILabel alloc]initWithFrame:CGRectMake(45, 130*WIDTH_SCALE+70*WIDTH_SCALE, self.view.frame.size.width - 30, 30*HEIGHT_SCALE)];
    leftLable2.text = @"昵称";
    leftLable2.textColor = RGBColor(69, 69, 69);
    leftLable2.font = [UIFont systemFontOfSize:14];
    leftLable2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:leftLable2];
    [self.view addSubview:self.nickimg];
    
    field = [[UITextField alloc]initWithFrame:CGRectMake(10, 160*WIDTH_SCALE+70*WIDTH_SCALE, WIDTH-100*HEIGHT_SCALE, 40*HEIGHT_SCALE) ];
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.font = [UIFont systemFontOfSize:12];
    field.placeholder = @"输入您想要的昵称";
    
    field.delegate = self;
    [self.view addSubview:field];
    
    UIButton *dengluBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, DEVICE_HEIGHT-50*HEIGHT_SCALE-14*HEIGHT_SCALE,DEVICE_WIDTH-80*WIDTH_SCALE, 50*HEIGHT_SCALE)];
    [dengluBtn setTitle:@"完成" forState:UIControlStateNormal];
    [dengluBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dengluBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [dengluBtn setBackgroundColor:RGBColor(203, 70, 111)];
    dengluBtn.layer.cornerRadius = 25;
    [dengluBtn addTarget:self action:@selector(dengluBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dengluBtn];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0 , 210*HEIGHT_SCALE+70*HEIGHT_SCALE, self.view.frame.size.width, 2)];
    lineView2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:lineView2];
    
    UILabel *leftLable3 = [[UILabel alloc]initWithFrame:CGRectMake(45, 210*HEIGHT_SCALE+70*HEIGHT_SCALE, self.view.frame.size.width - 30*WIDTH_SCALE, 30*HEIGHT_SCALE)];
    leftLable3.text = @"性别";
    leftLable3.textColor = RGBColor(69, 69, 69);
    leftLable3.font = [UIFont systemFontOfSize:14];
    leftLable3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:leftLable3];
    [self.view addSubview:self.xinbieimg];
    
    UILabel *nanLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-20*WIDTH_SCALE-60*WIDTH_SCALE-70*WIDTH_SCALE, 265*HEIGHT_SCALE+70*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE)];
    nanLable.text = @"男";
    nanLable.textColor = RGBColor(69, 69, 69);
    nanLable.font = [UIFont systemFontOfSize:14];
    nanLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nanLable];
    
    UIButton *nanBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-20*WIDTH_SCALE-60*WIDTH_SCALE, 250*HEIGHT_SCALE+70*HEIGHT_SCALE, 60*WIDTH_SCALE, 60*HEIGHT_SCALE)];
    nanBtn.selected = YES;
    nanBtn.tag = 100;
    [nanBtn setBackgroundImage:[UIImage imageNamed:@"填写信息_07"] forState:UIControlStateNormal];
    [nanBtn setBackgroundImage:[UIImage imageNamed:@"e-"] forState:UIControlStateSelected];
    [nanBtn addTarget:self action:@selector(nan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nanBtn];
    
    UILabel *nvLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+20*WIDTH_SCALE+60*WIDTH_SCALE+10*WIDTH_SCALE, 265*HEIGHT_SCALE+70*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE)];
    nvLable.text = @"女";
    nvLable.textColor = RGBColor(69, 69, 69);
    nvLable.font = [UIFont systemFontOfSize:14];
    nvLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:nvLable];
    
    UIButton *nvBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2+20*WIDTH_SCALE, 250*HEIGHT_SCALE+70*HEIGHT_SCALE, 60*WIDTH_SCALE, 60*HEIGHT_SCALE)];
    nvBtn.selected = NO;
    nvBtn.tag = 200;
    [nvBtn setBackgroundImage:[UIImage imageNamed:@"ee"] forState:UIControlStateNormal];
    [nvBtn setBackgroundImage:[UIImage imageNamed:@"填写信息_09"] forState:UIControlStateSelected];
    [nvBtn addTarget:self action:@selector(nv:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nvBtn];
    
    UILabel *centerLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 320*WIDTH_SCALE+70*WIDTH_SCALE, WIDTH, 30*HEIGHT_SCALE)];
    centerLable.text = @"性别一旦确定不能更改哦";
    centerLable.textColor = RGBColor(69, 69, 69);
    centerLable.font = [UIFont systemFontOfSize:12];
    centerLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:centerLable];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0 , 350*HEIGHT_SCALE+70*HEIGHT_SCALE, self.view.frame.size.width, 2)];
    lineView3.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:lineView3];
    
    UILabel *leftLable4 = [[UILabel alloc]initWithFrame:CGRectMake(45*WIDTH_SCALE, 360*HEIGHT_SCALE+70*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE)];
    leftLable4.text = @"位置";
    leftLable4.textColor = RGBColor(69, 69, 69);
    leftLable4.font = [UIFont systemFontOfSize:14];
    leftLable4.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:leftLable4];
    [self.view addSubview:self.addimg];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0 , 390*HEIGHT_SCALE+70*HEIGHT_SCALE, self.view.frame.size.width, 40*HEIGHT_SCALE)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2)];
    [bottomView addGestureRecognizer:tap2];
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, self.view.frame.size.width, 1)];
    lineView4.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [bottomView addSubview:lineView4];
    
    UILabel *leftLable5 = [[UILabel alloc]initWithFrame:CGRectMake(15*WIDTH_SCALE, 5*HEIGHT_SCALE, 30*WIDTH_SCALE, 30*HEIGHT_SCALE)];
    leftLable5.text = @"地区";
    leftLable5.textColor = RGBColor(69, 69, 69);
    leftLable5.font = [UIFont systemFontOfSize:12];
    leftLable5.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:leftLable5];
    
    cityLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-100*WIDTH_SCALE, 5*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE)];
    cityLable.text = @"北京";
    cityLable.tag = 500;
    cityLable.textColor = RGBColor(69, 69, 69);
    cityLable.font = [UIFont systemFontOfSize:12];
    cityLable.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:cityLable];
    
    UIView *lineView5 = [[UIView alloc]initWithFrame:CGRectMake(0 , 39*HEIGHT_SCALE, self.view.frame.size.width, 1)];
    lineView5.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [bottomView addSubview:lineView5];
    
    UIView *lineView6 = [[UIView alloc]initWithFrame:CGRectMake(0 , 450*HEIGHT_SCALE+70*HEIGHT_SCALE, self.view.frame.size.width, 2)];
    lineView6.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    //[self.view addSubview:lineView6];
    
}
-(void)tap2{
    cityViewController *city = [[cityViewController alloc]init];
    city.city = @"1";
    [self.navigationController pushViewController:city animated:YES];
}
-(void)nan:(UIButton *)btn{
    UIButton *nan = (id)[self.view viewWithTag:100];
    UIButton *nv = (id)[self.view viewWithTag:200];

    nan.selected = YES;
    sex = @"1";
    nv.selected = NO;

    
}
-(void)nv:(UIButton *)btn{
    UIButton *nan = (id)[self.view viewWithTag:100];
    UIButton *nv = (id)[self.view viewWithTag:200];
    sex = @"0";
    nv.selected = YES;
    nan.selected = NO;
  
}
-(void)dengluBtn:(UIButton *)btn
{
    MB=[NSObject showHUDView:self.view MBText:@"正在注册"];
    [AFManager postReqURL:ZHUCE reqBody:@{@"phone":self.phone,@"password":self.password,@"repass":self.repassword} block:^(id infor) {
        if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"200"])
        {
            NSDictionary *dic = @{@"id":infor[@"id"],@"nickname":field.text,@"sex":sex,@"area":cityLable.text};
            
            AFHTTPSessionManager* sessinManager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:UPPICTURE]];
            sessinManager.responseSerializer=[AFJSONResponseSerializer serializer];
            sessinManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
            //增加这几行代码；
            AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
            [securityPolicy setAllowInvalidCertificates:YES];
            
            //这里进行设置；
            [sessinManager setSecurityPolicy:securityPolicy];
            sessinManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [sessinManager POST:UPPICTURE parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
             {
                 [formData appendPartWithFileData:array[0] name:@"file" fileName:@"file.png" mimeType:@"image/jpg"];
             } progress:^(NSProgress * _Nonnull uploadProgress)
             {
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                 if ([[NSString stringWithFormat:@"%@",dic[@"code"]] isEqualToString:@"200"])
                 {
                     [USERDEFAULT setValue:dic[@"id"] forKey:@"uid"];
                     [USERDEFAULT setValue:dic[@"nickname"] forKey:@"nickname"];
                     [USERDEFAULT setValue:dic[@"imgUrl"] forKey:@"imgUrl"];
                     [USERDEFAULT setValue:dic[@"account"] forKey:@"account"];
                     [USERDEFAULT synchronize];
                     [AFManager getReqURL:[NSString stringWithFormat:@"%@?id=%@",TOKEN,dic[@"id"]] block:^(id inforss)
                     {
                         if ([[NSString stringWithFormat:@"%@",inforss[@"code"]] isEqualToString:@"200"])
                         {
                             [USERDEFAULT setValue:inforss[@"token"] forKey:@"token"];
                             [USERDEFAULT synchronize];
                             [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
                         }
                         [MB hide:YES];

                     } errorblock:^(NSError *error)
                     {
                         [MB hide:YES];
                     }];
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 [MB hide:YES];
             }];

            
        }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"201"]){
            [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"用户已被注册" andSelfVC:self];
            [MB hide:YES];
        }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"202"]){
            [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"密码输入不一致" andSelfVC:self];
            [MB hide:YES];
        }else if ([[NSString stringWithFormat:@"%@",infor[@"code"]] isEqualToString:@"203"]){
            [NSObject wj_alterSingleVCWithOneTitle:@"提示" andTwoTitle:@"注册失败" andSelfVC:self];
            [MB hide:YES];
        }
        
    }];
}
-(void)image{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageView.image = myImage;
     NSData *data=UIImageJPEGRepresentation(myImage, 0.01);
    [array addObject:data];
    //    NSData * imageData = UIImageJPEGRepresentation(myImage, 0.01);
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(wanshanView *)wanshanview
{
    if(!_wanshanview)
    {
        _wanshanview = [[wanshanView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200*HEIGHT_SCALE)];
        _wanshanview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景121"]];
    }
    return _wanshanview;
}

-(UIImageView *)xinbieimg
{
    if(!_xinbieimg)
    {
        _xinbieimg = [[UIImageView alloc] initWithFrame:CGRectMake(15*WIDTH_SCALE, 290*HEIGHT_SCALE, 15*WIDTH_SCALE, 15*HEIGHT_SCALE)];
        _xinbieimg.image = [UIImage imageNamed:@"填写信息_14"];
    }
    return _xinbieimg;
}

-(UIImageView *)nickimg
{
    if(!_nickimg)
    {
        _nickimg = [[UIImageView alloc] initWithFrame:CGRectMake(15*WIDTH_SCALE, 210*HEIGHT_SCALE, 15*WIDTH_SCALE, 15*HEIGHT_SCALE)];
        _nickimg.image = [UIImage imageNamed:@"填写信息_071"];
    }
    return _nickimg;
}

-(UIImageView *)addimg
{
    if(!_addimg)
    {
        _addimg = [[UIImageView alloc] initWithFrame:CGRectMake(15*WIDTH_SCALE, 360*HEIGHT_SCALE+75*HEIGHT_SCALE, 15*WIDTH_SCALE, 15*HEIGHT_SCALE)];
        _addimg.image = [UIImage imageNamed:@"填写信息_25"];
    }
    return _addimg;
}

@end
