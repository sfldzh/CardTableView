//
//  UITableView+CardGroupProperty.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/23.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "UITableView+CardGroupProperty.h"
#import <objc/runtime.h>

@implementation UITableView (CardGroupProperty)
- (void)setProperty:(TableViewPropertyForCardGroup *)property{
    objc_setAssociatedObject(self, @selector(property), property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TableViewPropertyForCardGroup *)property{
    TableViewPropertyForCardGroup *property = objc_getAssociatedObject(self, _cmd);
    if (!property) {
        property = [[TableViewPropertyForCardGroup alloc] init];
        self.property = property;
    }
    return property;
}

@end
