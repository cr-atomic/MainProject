//
//  CRMediator.m
//  CRMediator
//
//  Created by roger wu on 09/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRMediator.h"
#import "CRNotFoundController.h"

#define kTargetPrefix @"Target"
#define kActionPrefix @"Action"

@interface CRMediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

@implementation CRMediator

+ (instancetype)shareInstance {
    static CRMediator *mediator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [CRMediator new];
    });
    return mediator;
}

#pragma mark - Public Methods
- (id)performWithURL:(NSURL *)url {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *queryString = url.query;
    for (NSString *param in [queryString componentsSeparatedByString:@"&"]) {
        NSArray *element = [param componentsSeparatedByString:@"="];
        if (element.count < 2) continue;
        [params setObject:element.lastObject forKey:element.firstObject];
    }
    
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    return [self performWithTargetName:url.host
                            actionName:actionName
                                params:params
                           cacheTarget:NO];
}

- (id)performWithTargetName:(NSString *)targetName
                 actionName:(NSString *)actionName
                     params:(NSDictionary *)params
                cacheTarget:(BOOL)cacheTarget {
    NSString *targetClassString = [NSString stringWithFormat:@"%@_%@", kTargetPrefix, targetName];
    NSString *actionString = [NSString stringWithFormat:@"%@_%@:", kActionPrefix, actionName];
    
    NSObject *target = self.cachedTarget[targetClassString];
    if (!target) {
        Class targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    
    if (!target) {
        return [CRNotFoundController new];
    }
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。
    // 这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    if ([actionName hasPrefix:@"native"]) {
        return [CRNotFoundController new];
    }
    
    if (cacheTarget) {
        self.cachedTarget[targetClassString] = target;
    }
    
    SEL action = NSSelectorFromString(actionString);
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target params:params];
    } else {
        // 有可能target是Swift对象
        actionString = [NSString stringWithFormat:@"%@_%@WithParams:", kActionPrefix, actionName];
        action = NSSelectorFromString(actionString);
        if ([target respondsToSelector:action]) {
            return [self safePerformAction:action target:target params:params];
        } else {
            // 处理无响应请求
            action = NSSelectorFromString(@"notFound");
            if ([target respondsToSelector:action]) {
                // 尝试调用对应 target 的 notFound 方法处理
                return [self safePerformAction:action target:target params:params];
            } else {
                // 最终什么都没找到,移除cache的对象
                [self removeCachedTargetWithTargetName:targetName];
                return [CRNotFoundController new];
            }
        }
    }
}

- (id)performWithTargetName:(NSString *)targetName
                 actionName:(NSString *)actionName
                     params:(NSDictionary *)params {
    return [self performWithTargetName:targetName
                            actionName:actionName
                                params:params
                           cacheTarget:NO];
}

- (void)removeCachedTargetWithTargetName:(NSString *)targetName {
    NSString *targetClassString = [NSString stringWithFormat:@"%@_%@", kTargetPrefix, targetName];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - Private Methods
- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:action];
    if(methodSignature == nil) {
        return nil;
    }
    const char* returnType = [methodSignature methodReturnType];
    
    if (strcmp(returnType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }
}

- (NSMutableDictionary *)cachedTarget {
    if (!_cachedTarget) {
        _cachedTarget = [NSMutableDictionary dictionary];
    }
    return _cachedTarget;
}

@end
