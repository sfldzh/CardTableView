//
//  CardFrameView.h
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/23.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardFrameView : UIView
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, strong) UIColor *subBackgroundColor;
@property (nonatomic, strong) UIColor *subBorderColor;
@property (nonatomic, assign) CGFloat subBorderWidth;
@end

NS_ASSUME_NONNULL_END
