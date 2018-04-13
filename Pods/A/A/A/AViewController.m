//
//  AViewController.m
//  A
//
//  Created by roger wu on 10/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "AViewController.h"
#import <B_Category/CRMediator+B.h>

@interface AViewController ()

@property (strong, nonatomic) UILabel *showLabel;
@property (strong, nonatomic) UIButton *button;

@end

@implementation AViewController

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.showLabel.text = text;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AViewController";
    [self setupViews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.showLabel sizeToFit];
    self.showLabel.center = self.view.center;
    
    _button.center = CGPointMake(_showLabel.center.x, _showLabel.center.y+50);
}

- (UILabel *)showLabel {
    if (_showLabel == nil) {
        _showLabel = [UILabel new];
        _showLabel.textColor = [UIColor redColor];
    }
    return _showLabel;
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_showLabel];
    
    _button = [UIButton new];
    [_button setTitle:@"进入BViewController" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_button sizeToFit];
    [self.view addSubview:_button];
}

- (void)buttonAction:(UIButton *)button {
    UIViewController *bVC = [[CRMediator shareInstance] bViewControllerWithText:@"A进入到B显示文字"];
    if (self.navigationController) {
        [self.navigationController pushViewController:bVC animated:YES];
    } else {
        [self presentViewController:bVC animated:YES completion:nil];
    }
}


@end














