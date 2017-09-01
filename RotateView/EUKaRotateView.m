//
//  EUKaRotateView.m
//  菁优网首页动画
//
//  Created by EUKaAccount on 2017/8/17.
//  Copyright © 2017年 chenlin. All rights reserved.
//


#import "EUKaRotateView.h"
#import "EUKaRotateBtn.h"

@interface EUKaRotateView ()
// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) CGPoint contentCenterPoint; // 旋转的弧度
@property (nonatomic, assign) CGFloat rotationAngleInRadians; // 旋转的弧度
@property (nonatomic, strong) UIView *contentView; // 内容View，当transform发生时，会影响frame，继而影响中点以及startPoint，所以此处加了一层内容层

@property(nonatomic,assign) BOOL hidden;
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) UILabel *centerLabel;
@property(nonatomic,strong) UIPanGestureRecognizer *pan;
@end

@implementation EUKaRotateView
@synthesize selectedModel = _selectedModel;

- (NSMutableArray *)btnArray {
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _btnArray;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(paned:)];
        [self addGestureRecognizer:pan];
        self.pan = pan;
        
        UIView  *contentView = [UIView new];
        contentView.frame = self.bounds;
        contentView.layer.cornerRadius = self.frame.size.width / 2;
        contentView.backgroundColor = [UIColor blueColor];
        [self addSubview:contentView];
        self.contentView = contentView;
    
        self.contentCenterPoint = CGPointMake(self.contentView.frame.size.width * 0.5, self.contentView.frame.size.height * 0.5);
        _radiusScale = 0.7;
        _btnWidth = 60;
        [self setUPCenter];
        //        [self addGestureRecognizer:[[CLCustomRotationGestureRecognizer alloc] initWithTarget:self action:@selector(changeMove:)]];
        
    }
    return self;
}

- (void)setUPCenter {
    self.centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.centerBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    [self.centerBtn addTarget:self action:@selector(centerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    self.centerBtn.backgroundColor = [UIColor redColor];
    //
    self.centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.centerBtn.frame.origin.x - 20, self.centerBtn.frame.origin.y + self.centerBtn.frame.size.height, self.centerBtn.frame.size.width + 40, 20)];
    self.centerLabel.textAlignment = NSTextAlignmentCenter;
    self.centerLabel.textColor = [UIColor lightTextColor];
    self.centerLabel.font = titleFont;
    [self addSubview:self.centerLabel];
    
}

- (void)setBtnModels:(NSArray<EUKaRotateModel *> *)btnModels {
    _btnModels = btnModels;
    [self.btnArray removeAllObjects];
    for (EUKaRotateModel *model in btnModels) {
        EUKaRotateBtn *btn = [[EUKaRotateBtn alloc] init];
        btn.model = model;
        [self.btnArray addObject:btn];
    }
    [self setUPBtns];
}
- (void)setBtnWidth:(CGFloat)btnWidth andRadiusScale:(CGFloat)scale{
    _btnWidth = btnWidth;
    _radiusScale = scale;
    [self setUPBtns];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    CGRect frameOfSuperView =  [self convertRect:self.centerBtn.frame toView:self.superview];
    self.centerBtn.frame = frameOfSuperView;
    [self.superview addSubview:self.centerBtn];
    
    // 加入父控件自动启动点击事件
    [self btnClicked:self.btnArray[0]];
}
- (void)setUPBtns {
    NSInteger btnCount = self.btnArray.count;
    CGFloat baseWidth = self.contentView.frame.size.width;
    CGFloat perCorner = -M_PI * 2.0 / btnCount;
    
    CGFloat r = baseWidth * _radiusScale / 2 ;
    CGFloat x = baseWidth  / 2.0 ;
    CGFloat y = baseWidth  / 2.0 ;
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < btnCount; i++) {
        EUKaRotateBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(0, 0, _btnWidth, _btnWidth);
        btn.layer.masksToBounds = YES;
        btn.titlefont = titleFont;
//        btn.backgroundColor = [UIColor redColor];
        
        CGFloat  corner = (i * perCorner + M_PI_2);//(i + 3 - 0.1) * 1.0;
        btn.center = CGPointMake(x + r * cos(corner), y + r *sin(corner));
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}


- (void)btnClicked:(EUKaRotateBtn *)btn {
    [UIView animateWithDuration:0.5 animations:^{
        if (_hidden) {
            self.contentView.transform = CGAffineTransformIdentity;
            self.centerLabel.alpha = 1;
        } else {
            self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            self.centerLabel.alpha = 0;
        }
        self.centerLabel.text = btn.model.title;
        [self.centerBtn setImage:[UIImage imageNamed:btn.model.imageSelectedName] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        if (_hidden) {
            [self addGestureRecognizer:self.pan];
            _hidden = NO;
        } else {
            [self removeGestureRecognizer:self.pan];
            _hidden = YES;
        }
//        self.centerLabel.hidden = _hidden;
        self.userInteractionEnabled = !_hidden;
        if (self.myBackBlock) {
            _selectedModel = btn.model;
            self.myBackBlock(btn.model);
        }
    }];
    NSLog(@"%s",__func__);
}
- (void)setSelectedModel:(EUKaRotateModel *)selectedModel {
    for (EUKaRotateBtn *btn in self.btnArray) {
        if (btn.model == selectedModel) { // 这里以模型说话
            _selectedModel = selectedModel;
            self.centerLabel.text = selectedModel.title;
            [self.centerBtn setImage:[UIImage imageNamed:selectedModel.imageSelectedName] forState:UIControlStateNormal];
            [self closeItems];
            return;
        }
    }
}
- (EUKaRotateModel *)selectedModel {
    return _selectedModel;
}
- (void)centerBtnClicked:(UIButton *)btn {
    NSLog(@"%s",__func__);
    [UIView animateWithDuration:0.5 animations:^{
        if (_hidden) {
            self.contentView.transform = CGAffineTransformIdentity;
            self.centerLabel.alpha = 1;
            
            // 以下两行必须加上
            for (EUKaRotateBtn *btn in self.btnArray) {
                btn.transform = CGAffineTransformMakeRotation( - self.rotationAngleInRadians);
            }
            self.contentView.transform = CGAffineTransformMakeRotation(self.rotationAngleInRadians);
            
        } else {
            self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            self.centerLabel.alpha = 0;
        }
        
    } completion:^(BOOL finished) {
        if (_hidden) {
            _hidden = NO;
            [self addGestureRecognizer:self.pan];
        } else {
            _hidden = YES;
            [self removeGestureRecognizer:self.pan];
        }
        self.userInteractionEnabled = !_hidden;
    }];
    
}

- (void)closeItems {
    if (_hidden == NO) {
        [self centerBtnClicked:self.centerBtn];
    }
}
- (void)paned:(UIPanGestureRecognizer *)pan {
    NSLog(@"%s",__FUNCTION__);
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startPoint = [pan locationInView:self];
        NSLog(@"startPoint = %@ ,, centerPoint = %@",NSStringFromCGPoint(self.startPoint),NSStringFromCGPoint(self.center));
        NSLog(@"%sUIGestureRecognizerStateBegan",__FUNCTION__);
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        NSLog(@"%sUIGestureRecognizerStateChanged",__FUNCTION__);
        CGPoint point = [pan locationInView:self];
        CGFloat angleInRadians = atan2f(point.y - self.contentCenterPoint.y, point.x - self.contentCenterPoint.x) - atan2f(self.startPoint.y - self.contentCenterPoint.y, self.startPoint.x - self.contentCenterPoint.x);
        NSLog(@"angleRadins = %lf",angleInRadians);
//        self.rotationAngleInRadians += angleInRadians;
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.transform = CGAffineTransformMakeRotation(angleInRadians + self.rotationAngleInRadians);
            for (UIButton *btn in self.btnArray) {
                btn.transform = CGAffineTransformMakeRotation(-(angleInRadians + self.rotationAngleInRadians));
            }
        }];
        
    } else {
        CGPoint endPoint = [pan locationInView:self];
        CGFloat angleInRadians = atan2f(endPoint.y - self.contentCenterPoint.y, endPoint.x - self.contentCenterPoint.x) - atan2f(self.startPoint.y - self.contentCenterPoint.y, self.startPoint.x - self.contentCenterPoint.x);
        self.rotationAngleInRadians += angleInRadians;
        NSLog(@"%sUIGestureRecognizerStateEnd",__FUNCTION__);
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}
// 当手势一旦被识别，将不会调用此方法（如果添加了手势，开始滑动的初期会调用此方法）
// 当移除手势之后，此方法被调用，控制器的此方法也被调用，但是地图滑动手势不被识别
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__FUNCTION__);
    [super touchesMoved:touches withEvent:event];
}


@end
