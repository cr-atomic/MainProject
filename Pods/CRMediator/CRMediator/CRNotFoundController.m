//
//  CRNotFoundController.m
//  CRMediator
//
//  Created by roger wu on 09/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRNotFoundController.h"

@interface CRNotFoundController ()

@end

@implementation CRNotFoundController {
    UILabel *_notFoundLabel;
    UILabel *_noticeLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"404";
    [self setupViews];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    _notFoundLabel = [UILabel new];
    _notFoundLabel.font = [UIFont boldSystemFontOfSize:50];
    _notFoundLabel.textColor = [UIColor lightGrayColor];
    _notFoundLabel.textAlignment = NSTextAlignmentCenter;
    _notFoundLabel.text = @"404";
    [self.view addSubview:_notFoundLabel];
    
    _noticeLabel = [UILabel new];
    _noticeLabel.font = [UIFont systemFontOfSize:25];
    _noticeLabel.textColor = _notFoundLabel.textColor;
    _noticeLabel.textAlignment = NSTextAlignmentCenter;
    _noticeLabel.numberOfLines = 0;
    _noticeLabel.text = @"当前没有相对应的内容\n不过你可以在app里别的地方再逛逛";
    [self.view addSubview:_noticeLabel];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat notFoundHeight = 60;
    CGFloat notFoundY = (screenHeight - notFoundHeight)/2 - 100;
    _notFoundLabel.frame = CGRectMake(0, notFoundY, screenWidth, notFoundHeight);
    
    
    CGFloat noticeLabelWidth = screenWidth - 30;
    CGFloat noticeLabelHeight = 160;
    CGFloat noticeLabelX = (screenWidth - noticeLabelWidth)/2;
    CGFloat noticeLabelY = CGRectGetMaxY(_notFoundLabel.frame) + 10;
    _noticeLabel.frame = CGRectMake(noticeLabelX, noticeLabelY, noticeLabelWidth, noticeLabelHeight);
    
    
    UIColor *buttonColor = [UIColor lightGrayColor];
    if (self.navigationController) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(back)];
        self.navigationItem.leftBarButtonItem.tintColor = buttonColor;
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:buttonColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.frame = CGRectMake(15, 20, 40, 40);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)back {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
