//
//  TableViewPropertyForCardGroup.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/22.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "TableViewPropertyForCardGroup.h"
#import "GroupCard.h"

@implementation TableViewPropertyForCardGroup
- (instancetype)init{
    if (self = [super init]) {
        self.visibleSectionMax = TableViewGroupCardUndisplaySection;
        self.visibleSectionMin = TableViewGroupCardUndisplaySection;
        
        _displayings = [NSMutableDictionary dictionary];
        _undisplayCards = [NSMutableDictionary dictionary];
        _registedClassDic = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
