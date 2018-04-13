//
//  CRMediator+B.h
//  B_Category
//
//  Created by roger wu on 10/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <CRMediator/CRMediator.h>
#import <UIKit/UIKit.h>

@interface CRMediator (B)

/**
 返回B业务视图实例

 @param text 显示文字
 @return return value description
 */
- (UIViewController *)bViewControllerWithText:(NSString *)text;

@end
