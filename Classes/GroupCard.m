//
//  GroupCard.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/23.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "GroupCard.h"
#import <objc/runtime.h>

/// TODO: 方法替换
/// @param c 类
/// @param origSEL 原方法
/// @param newSEL 新方法
void tableCardSwizzleSelector(Class c, SEL origSEL, SEL newSEL){
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if (!origMethod) {
        origMethod = class_getClassMethod(c, origSEL);
        if (!origMethod) {
            return;
        }
        newMethod = class_getClassMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
        if (!newMethod) {
            return;
        }
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}
