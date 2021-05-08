//
//  TableViewGroupCard.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/22.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "TableViewGroupCard.h"
#import "GroupCard.h"
#import "UIView+TableViewGroupCard.h"

@implementation TableViewGroupCard
- (instancetype)init{
    if (self = [super init]) {
        self.section = TableViewGroupCardUndisplaySection;
    }
    return self;
}

- (void)setCardView:(UIView *)cardView{
    _cardView = cardView;
    cardView.tableViewGroupCard = self;
}
@end
