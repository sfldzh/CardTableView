//
//  TableViewGroupCard.h
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/22.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewGroupCard : NSObject
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, strong) UIView *cardView;
@end

NS_ASSUME_NONNULL_END
