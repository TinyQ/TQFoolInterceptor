//
//  TQFoolInterceptor.m
//  TQFoolInterceptor
//
//  Created by qfu on 9/2/15.
//  Copyright (c) 2015 qfu. All rights reserved.
//

#import "TQFoolInterceptor.h"
#import <objc/runtime.h>

@implementation TQFoolInterceptor

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[self class] handleFoolClassName:@"__NSPlaceholderArray" method:@selector(initWithObjects:count:)];
        [[self class] handleFoolClassName:@"__NSArrayI" method:@selector(objectAtIndex:)];
        [[self class] handleFoolClassName:@"__NSArrayM" method:@selector(insertObject:atIndex:)];
        [[self class] handleFoolClassName:@"__NSPlaceholderDictionary" method:@selector(initWithObjects:forKeys:count:)];
        
        
    });
}

+ (void)handleFoolClassName:(NSString *)className method:(SEL)origSel
{
    NSError *error = nil;
    
    Class class = NSClassFromString(className);
    
    NSString *origSelStr = NSStringFromSelector(origSel);
    NSString *altSelStr  = [NSString stringWithFormat:@"fool_%@",origSelStr];
    
    SEL altSel = NSSelectorFromString(altSelStr);
    
    [[self class] swizzleForClass:class method:origSel withMethod:altSel error:&error];
    
    if (error) {
        NSLog(@"%@",error); //TODO:
    }
}

+ (void)swizzleForClass:(Class)class method:(SEL)origSel withMethod:(SEL)altSel error:(NSError**)error
{
    Method originalMethod = class_getInstanceMethod(class, origSel);
    Method swizzledMethod = class_getInstanceMethod(class, altSel);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    origSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            altSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end

#pragma mark - NSArray FoolInterceptor

@implementation NSArray(FoolInterceptor)

- (instancetype)fool_initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    for (int i = 0; i<cnt; i++)
    {
        if(objects[i] == nil)
        {
            return [NSArray array];
        }
    }
    
    return [self fool_initWithObjects:objects count:cnt];
}

- (id)fool_objectAtIndex:(NSUInteger)index
{
    if (index >= self.count)
    {
        return nil;
    }
    
    return [self fool_objectAtIndex:index];
}

@end

#pragma mark - NSMutableArray FoolInterceptor

@implementation NSMutableArray(FoolInterceptor)

- (void)fool_insertObject:(id)anObject atIndex:(NSUInteger)index;
{
    if (anObject == nil)
    {
        return;
    }
    
    [self fool_insertObject:anObject atIndex:index];
}

@end

#pragma mark - NSDictionary FoolInterceptor

@implementation NSDictionary(FoolInterceptor)

- (instancetype)fool_initWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt
{
    for (int i = 0; i<cnt; i++)
    {
        if(objects[i] == nil || keys[i] == nil)
        {
            return [NSDictionary dictionary];
        }
    }
    
    return [self fool_initWithObjects:objects forKeys:keys count:cnt];
}

@end
