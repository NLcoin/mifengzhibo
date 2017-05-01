//
//  leftView1.m
//  LeQuVRZhiBo
//
//  Created by 王俊钢 on 2016/12/31.
//  Copyright © 2016年 lhb. All rights reserved.
//

#import "leftView1.h"
@interface leftView1()
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UILabel *lab;
@end
@implementation leftView1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftimg];
        [self addSubview:self.lab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimg.frame = CGRectMake(0,0, 40, 40);
    self.lab.frame = CGRectMake(30, 0, 60, 40);
}

#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.image = [UIImage imageNamed:@"密码2"];
    }
    return _leftimg;
}

-(UILabel *)lab
{
    if(!_lab)
    {
        _lab = [[UILabel alloc] init];
        _lab.text = @"密码";
        _lab.textColor = [UIColor whiteColor];
    }
    return _lab;
}


@end
