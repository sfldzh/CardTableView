//
//  BaseFromTableViewCell.h
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/24.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseFromTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL hiddenLine;
@property (nonatomic, assign) CGFloat lineLeft;
@property (nonatomic, assign) CGFloat lineRight;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@end

NS_ASSUME_NONNULL_END
