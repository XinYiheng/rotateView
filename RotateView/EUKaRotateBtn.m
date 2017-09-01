//
//  EUKaRotateBtn.m
//  菁优网首页动画
//
//  Created by EUKaAccount on 2017/8/17.
//  Copyright © 2017年 chenlin. All rights reserved.
//


#import "EUKaRotateBtn.h"

@interface EUKaRotateBtn ()
@property(nonatomic,strong) UIImageView *topImage;
@property(nonatomic,strong) UILabel *bottomLabel;
@end

@implementation EUKaRotateBtn
@synthesize textColor = _textColor;
@synthesize titlefont = _titlefont;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 2 /3.0)];
        self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topImage.frame.origin.y + self.topImage.frame.size.height , frame.size.width, frame.size.height / 3.0)];
        self.topImage.contentMode = UIViewContentModeScaleAspectFit;
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitlefont:[UIFont systemFontOfSize:12]];
        [self setTextColor:[UIColor whiteColor]];
        [self addSubview:self.topImage];
        [self addSubview:self.bottomLabel];
        //        self.backgroundColor = [UIColor redColor];
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.topImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2 /3.0);
    self.bottomLabel.frame = CGRectMake(0, self.topImage.frame.origin.y + self.topImage.frame.size.height , self.frame.size.width, self.frame.size.height / 3.0);
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.bottomLabel.textColor = textColor;
}
- (UIColor *)textColor {
    return _textColor;
}
- (void)setTitlefont:(UIFont *)font {
    _titlefont = font;
    self.bottomLabel.font = font;
}
- (UIFont *)titlefont {
    return _titlefont;
}

// 点击的时候 怎么会调用此方法呢，因此内容偏移
- (void)layoutSubviews {
    [super layoutSubviews];

//    self.topImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 2 /3.0);
//    self.bottomLabel.frame = CGRectMake(0, self.topImage.frame.origin.y + self.topImage.frame.size.height , self.frame.size.width, self.frame.size.height / 3.0);
}
- (void)setModel:(EUKaRotateModel *)model {
    _model = model;
    self.topImage.image = [UIImage imageNamed:model.imageName];
    self.bottomLabel.text = model.title;
    
    //    [self setImage:[UIImage imageNamed:[_modelArray[i] imageName]] forState:UIControlStateNormal];
    //    [self setImage:[UIImage imageNamed:[_modelArray[i] imageSelectedName]] forState:UIControlStateNormal];
    //    [self setTitleColor:EUKaTextWhiteColor forState:UIControlStateNormal];
    //    [self setTitle:[_modelArray[i] name] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.topImage.image = [UIImage imageNamed:self.model.imageSelectedName];
    } else {
        self.topImage.image = [UIImage imageNamed:self.model.selectedtitle];
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return [super titleRectForContentRect:contentRect];
}
@end
