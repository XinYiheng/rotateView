//
//  EUKaRotateView.h
//  菁优网首页动画
//
//  Created by EUKaAccount on 2017/8/17.
//  Copyright © 2017年 chenlin. All rights reserved.
//
#define EUKaWeak(object)  __weak typeof(object) weak##object = object;
#define kLenthBasedIphone6(iphone6W)   ((iphone6W)*([UIScreen mainScreen].bounds.size.width)/375.0)
#define kSystemFont(iphone6Px05)  [UIFont systemFontOfSize:(iphone6Px05)*([UIScreen mainScreen].bounds.size.width)/375.0]

#define titleFont kSystemFont(15)

#import <UIKit/UIKit.h>
#import "EUKaRotateModel.h"

@interface EUKaRotateView : UIView

@property(nonatomic,copy) void(^ myBackBlock)(EUKaRotateModel *model);

@property(nonatomic,strong) NSArray<EUKaRotateModel *> *btnModels;
@property(nonatomic,assign,readonly) CGFloat btnWidth;
// 取值0>>1
@property(nonatomic,assign,readonly) CGFloat radiusScale;
@property(nonatomic,strong) EUKaRotateModel *selectedModel;
//@property(nonatomic,assign) CGFloat btnWidth;
- (void)setBtnWidth:(CGFloat)btnWidth andRadiusScale:(CGFloat)scale;

- (void)closeItems;

@end
