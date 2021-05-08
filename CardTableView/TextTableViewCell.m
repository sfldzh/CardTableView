//
//  TextTableViewCell.m
//  card
//
//  Created by 施峰磊 on 2021/5/8.
//

#import "TextTableViewCell.h"
@interface TextTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLayout;

@end

@implementation TextTableViewCell

- (void)setLeft:(CGFloat)left{
    self.leftLayout.constant = left;
}

- (void)setRight:(CGFloat)right{
    self.rightLayout.constant = right;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
