//
//  UITableView+CardView.h
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/22.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TableCardGroupDataSource <NSObject>
/// TODO:获取CardView
/// @param tableView tableView
/// @param section 组索引
- (UIView *)tableView:(UITableView *)tableView cardViewForSection:(NSInteger)section;

/// TODO:卡片相距尺寸
/// @param tableView 表单
/// @param section 组索引
- (UIEdgeInsets)cardViewMarginForTableView:(UITableView *)tableView section:(NSInteger)section;

@end

@interface UITableView (CardView)
@property (nonatomic, weak) id<TableCardGroupDataSource> cardGroupDataSource;

/// TODO:获取cardView
/// @param reuseIdentifier 标记
/// @param section 组索引
- (UIView *)dequeueReusableGroupCardViewWithIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section;

/// TODO:注册卡片类
/// @param viewClass 卡片类
/// @param reuseIdentifier 标记
- (void)registerClass:(Class)viewClass forGroupCardViewReuseIdentifier:(NSString *)reuseIdentifier;
@end

NS_ASSUME_NONNULL_END
