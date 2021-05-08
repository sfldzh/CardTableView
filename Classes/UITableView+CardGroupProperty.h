//
//  UITableView+CardGroupProperty.h
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/23.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewPropertyForCardGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (CardGroupProperty)
@property (nonatomic, strong) TableViewPropertyForCardGroup *property;
@end

NS_ASSUME_NONNULL_END
