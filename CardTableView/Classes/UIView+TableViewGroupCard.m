//
//  UIView+TableViewGroupCard.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/22.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "UIView+TableViewGroupCard.h"
#import <objc/runtime.h>

@implementation UIView (TableViewGroupCard)

- (void)setTableViewGroupCard:(TableViewGroupCard *)tableViewGroupCard{
    objc_setAssociatedObject(self, @selector(tableViewGroupCard), tableViewGroupCard, OBJC_ASSOCIATION_ASSIGN);
}

- (TableViewGroupCard *)tableViewGroupCard{
    return objc_getAssociatedObject(self, _cmd);
}
@end
