//
//  wanshanView.m
//  LeQuVRZhiBo
//
//  Created by 王俊钢 on 2016/12/31.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "wanshanView.h"
@interface wanshanView()
@property (nonatomic,strong) UILabel *navlabel;
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UIImageView *bgimg;
@end
@implementation wanshanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgimg];
        [self addSubview:self.navlabel];
        [self addSubview:self.titlelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //self.navlabel.frame = CGRectMake(DEVICE_WIDTH/2-40, 20, 80, 40);
    //self.titlelabel.frame = CGRectMake(DEVICE_WIDTH/2-40, 70, 80, 40);
}

#pragma mark - getters

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        //_bgimg.image = [UIImage imageNamed:@"背景121"];
    }
    return _bgimg;
}

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"头像";
        _titlelabel.textColor = [UIColor whiteColor];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}

-(UILabel *)navlabel
{
    if(!_navlabel)
    {
        _navlabel = [[UILabel alloc] init];
        _navlabel.text = @"填写信息";
        _navlabel.textColor = [UIColor whiteColor];
        _navlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _navlabel;
}





@end
