//
//  EUKaRotateBtn.h
//  菁优网首页动画
//
//  Created by EUKaAccount on 2017/8/17.
//  Copyright © 2017年 chenlin. All rights reserved.
//
//#ifndef EUKaSCREEN_WIDTH
//#define EUKaSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#endif
//
//#ifndef kLenthBasedIphone6//(iphone6W)
//#define kLenthBasedIphone6(iphone6W)   ((iphone6W)*EUKaSCREEN_WIDTH/375.0)
//#endif
//#ifndef kSystemFont//(iphone6Px05)
//#define kSystemFont(iphone6Px05)  [UIFont systemFontOfSize:(iphone6Px05)*EUKaSCREEN_WIDTH/375.0]
//#endif
#import <UIKit/UIKit.h>
#import "EUKaRotateModel.h"

@interface EUKaRotateBtn : UIButton
@property(nonatomic,strong) EUKaRotateModel *model;
@property(nonatomic,strong)  UIFont *titlefont;
@property(nonatomic,strong)  UIColor *textColor;
@end
