//
//  Target_A.m
//  A
//
//  Created by roger wu on 10/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "Target_A.h"
#import "AViewController.h"

@implementation Target_A

- (UIViewController *)Action_viewController:(NSDictionary *)params {
    AViewController *vc = [[AViewController alloc] initWithText:params[@"text"]];
    return vc;
}

@end
