//
//  CRMediator+B.m
//  B_Category
//
//  Created by roger wu on 10/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRMediator+B.h"
#import <UIKit/UIKit.h>

@implementation CRMediator (B)

- (UIViewController *)bViewControllerWithText:(NSString *)text {
    return [self performWithTargetName:@"B" actionName:@"viewController" params:@{@"text": text}];
}

@end
