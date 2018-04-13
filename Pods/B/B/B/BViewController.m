//
//  BViewController.m
//  B
//
//  Created by roger wu on 10/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@property (strong, nonatomic) UILabel *showLabel;

@end

@implementation BViewController

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.showLabel.text = text;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_showLabel];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [_showLabel sizeToFit];
    _showLabel.center = self.view.center;
}

- (UILabel *)showLabel {
    if (_showLabel == nil) {
        _showLabel = [UILabel new];
        _showLabel.textColor = [UIColor redColor];
    }
    return _showLabel;
}

@end
