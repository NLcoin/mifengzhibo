//
//  setView.m
//  LeQuVRZhiBo
//
//  Created by 王俊钢 on 2017/1/2.
//  Copyright © 2017年 lhb. All rights reserved.
//

#import "setView.h"

@interface setView()
@property (nonatomic,strong) UILabel *label1;

@end

@implementation setView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label1];
        [self addSubview:self.text1];
        [self addSubview:self.roomlab];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.label1.frame = CGRectMake(30*WIDTH_SCALE, 40*HEIGHT_SCALE, self.frame.size.width-60*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.text1.frame = CGRectMake(30*WIDTH_SCALE, 80*HEIGHT_SCALE, self.frame.size.width-60*WIDTH_SCALE, 40*HEIGHT_SCALE);
    self.roomlab.frame = CGRectMake(self.frame.size.width/2, 130*HEIGHT_SCALE, self.frame.size.width/2, 30*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)label1
{
    if(!_label1)
    {
        _label1 = [[UILabel alloc] init];
        _label1.text = @"价格";
        _label1.textColor = [UIColor whiteColor];
        _label1.backgroundColor = [UIColor clearColor];
    }
    return _label1;
}

-(UITextField *)text1
{
    if(!_text1)
    {
        _text1 = [[UITextField alloc] init];
        _text1.placeholder = @"设置收费价格";
        _text1.layer.masksToBounds = YES;
        _text1.layer.borderWidth = 1;
        _text1.layer.cornerRadius = 4;
        _text1.textColor = [UIColor redColor];
        [_text1 setValue:[UIColor wjColorFloat:@"989898"] forKeyPath:@"_placeholderLabel.textColor"];
        _text1.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _text1;
}

-(UILabel *)roomlab
{
    if(!_roomlab)
    {
        _roomlab = [[UILabel alloc] init];
        _roomlab.text = @"房间号";
        _roomlab.textColor = [UIColor whiteColor];
    }
    return _roomlab;
}


@end
