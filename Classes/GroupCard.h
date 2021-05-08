//
//  GroupCard.h
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/23.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static const NSInteger TableViewGroupCardUndisplaySection = -1;

/// TODO: 方法替换
/// @param c 类
/// @param origSEL 原方法
/// @param newSEL 新方法
void tableCardSwizzleSelector(Class c, SEL origSEL, SEL newSEL);

NS_ASSUME_NONNULL_END
