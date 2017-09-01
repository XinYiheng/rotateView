//
//  ViewController.m
//  RotateView
//
//  Created by EUKaAccount on 2017/9/1.
//  Copyright © 2017年 Boat. All rights reserved.
//

#import "ViewController.h"
#import "EUKaRotateView.h"

@interface ViewController ()
@property(nonatomic,strong) EUKaRotateView *rotateView;
@property(nonatomic,strong) EUKaRotateModel *rotateModel;
@end

@implementation ViewController
- (void)setRotateModel:(EUKaRotateModel *)rotateModel {
    _rotateModel = rotateModel;
    self.navigationItem.title = rotateModel.title;
}

- (EUKaRotateView *)rotateView {
    if (_rotateView == nil) {
        _rotateView = [[EUKaRotateView alloc] initWithFrame:CGRectMake(0, 0, kLenthBasedIphone6(460), kLenthBasedIphone6(460))];
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:3];
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"EUkaRoundList.plist" ofType:nil];
        NSArray *contentArray = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *item  in contentArray) {
            EUKaRotateModel *model = [[EUKaRotateModel alloc]init];
            [model setValuesForKeysWithDictionary:item];
            [mArray addObject:model];
        }
        [_rotateView setBtnWidth:_rotateView.frame.size.width * 0.125 andRadiusScale:0.5];
        _rotateView.btnModels = mArray.copy;
        EUKaWeak(self)
        _rotateView.myBackBlock = ^(EUKaRotateModel *model) {
            weakself.rotateModel = model;
            
        };
    }
    return _rotateView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.rotateView.center = CGPointMake(self.view.frame.size.width * 0.5, 64 + kLenthBasedIphone6(50));
    [self.view addSubview:self.rotateView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
