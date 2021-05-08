//
//  TableViewPropertyForCardGroup.h
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/22.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableView+CardView.h"
#import "TableViewGroupCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewPropertyForCardGroup : NSObject
@property (nonatomic, weak) id<TableCardGroupDataSource> dataSource;

@property (nonatomic, assign) NSInteger visibleSectionMin; // 显示着的最小的section
@property (nonatomic, assign) NSInteger visibleSectionMax; // 显示着的最大的ssection

// 显示着的卡片
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TableViewGroupCard *> * displayings;
// 队列中未显示的卡片
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<TableViewGroupCard *> *> *undisplayCards;
// 注册过的类
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *registedClassDic;
@end

NS_ASSUME_NONNULL_END
