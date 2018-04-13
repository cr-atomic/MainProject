//
//  Target_B.m
//  B
//
//  Created by roger wu on 10/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "Target_B.h"
#import "BViewController.h"

@implementation Target_B

- (UIViewController *)Action_viewController:(NSDictionary *)params {
    BViewController *vc = [[BViewController alloc] initWithText:params[@"text"]];
    return vc;
}

@end
