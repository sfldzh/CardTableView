//
//  BaseFromTableViewCell.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/24.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "BaseFromTableViewCell.h"
@interface BaseFromTableViewCell()
@property (strong, nonatomic) UIView *line;
@end

@implementation BaseFromTableViewCell

- (UIColor *)hex:(int32_t)hex a:(CGFloat)a{
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0 green:((hex & 0xFF00) >> 8)/255.0 blue:(hex & 0xFF)/255.0 alpha:a];
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        if (@available(iOS 13.0, *)) {
            _line.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                    return [self hex:0xeeeeee a:1];
                }else {
                    return [self hex:0xffffff a:0.15];
                }
            }];
        }else{
            _line.backgroundColor = [self hex:0xeeeeee a:1];;
        }
    }
    return _line;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [self addViews];
}

- (void)addViews{
    [self addSubview:self.line];
}

- (void)setHiddenLine:(BOOL)hiddenLine{
    self.line.hidden = hiddenLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.line.frame = CGRectMake(self.lineLeft, CGRectGetHeight(self.frame)-0.8, CGRectGetWidth(self.frame)-(self.lineLeft+self.lineRight), 0.8);
}

@end
