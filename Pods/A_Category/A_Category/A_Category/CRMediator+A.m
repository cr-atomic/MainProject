//
//  CRMediator+A.m
//  A_Category
//
//  Created by roger wu on 10/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRMediator+A.h"

@implementation CRMediator (A)

- (UIViewController *)aViewControllerWithText:(NSString *)text {
    return [self performWithTargetName:@"A" actionName:@"viewController" params:@{@"text": text}];
}

@end
