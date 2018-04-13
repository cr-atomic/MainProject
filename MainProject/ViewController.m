//
//  ViewController.m
//  MainProject
//
//  Created by roger wu on 02/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "ViewController.h"
#import "CRMediator+A.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
}

- (IBAction)buttonAction:(id)sender {
    UIViewController *vc = [[CRMediator shareInstance] aViewControllerWithText:@"MainProject 进入显示文字"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
