//
//  CRMediator.h
//  CRMediator
//
//  Created by roger wu on 09/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 中间件,每个组件新增一个 category 来做逻辑处理
 */
@interface CRMediator : NSObject

+ (instancetype)shareInstance;

/**
 远程调用入口
 
 @param url 访问地址 [scheme]://[target]/[action]?[params] demo: wx://targetA/actionB?id=1234
 @return Action执行的返回结果
 */
- (id)performWithURL:(NSURL *)url;

/**
 本地调用
 
 @param targetName targetName description
 @param actionName actionName description
 @param params params description
 @param cacheTarget 是否缓存
 @return Action执行的返回结果
 */
- (id)performWithTargetName:(NSString *)targetName
actionName:(NSString *)actionName
params:(nullable NSDictionary *)params
cacheTarget:(BOOL)cacheTarget;

/**
 不缓存本地调用
 */
- (id)performWithTargetName:(NSString *)targetName
actionName:(NSString *)actionName
params:(nullable NSDictionary *)params;

/**
 删除缓存的Target
 
 @param targetName targetName description
 */
- (void)removeCachedTargetWithTargetName:(NSString *)targetName;

@end
NS_ASSUME_NONNULL_END

