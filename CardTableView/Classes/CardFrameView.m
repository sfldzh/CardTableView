//
//  CardFrameView.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/23.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "CardFrameView.h"

@interface CardFrameView ()
@property (nonatomic, strong)UIView *subView;

@end

@implementation CardFrameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)subView{
    if (!_subView) {
        _subView = [UIView new];
    }
    return _subView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configerView];
        [self addViews];
    }
    return self;
}

- (void)addViews{
    [self addSubview:self.subView];
}

- (void)configerView{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.zPosition = -1500;
}

- (void)setSubBorderColor:(UIColor *)subBorderColor{
    self.subView.layer.borderColor = subBorderColor.CGColor;
}

- (void)setSubBackgroundColor:(UIColor *)subBackgroundColor{
    self.subView.backgroundColor = subBackgroundColor;
}

- (void)setSubBorderWidth:(CGFloat)subBorderWidth{
    self.subView.layer.borderWidth = subBorderWidth;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.subView.frame = CGRectMake(self.padding.left, self.padding.top, CGRectGetWidth(self.frame)-(self.padding.left+self.padding.right), CGRectGetHeight(self.frame)-(self.padding.top+self.padding.bottom));
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return nil;
}

@end
