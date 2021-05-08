//
//  UITableView+CardView.m
//  CargoOwner
//
//  Created by 施峰磊 on 2020/4/22.
//  Copyright © 2020 施峰磊. All rights reserved.
//

#import "UITableView+CardView.h"
#import "UITableView+CardGroupProperty.h"
#import "UIView+TableViewGroupCard.h"
#import <objc/runtime.h>
#import "GroupCard.h"
#import "GroupCard.h"

@interface UIView (CardFrame)
@property (nonatomic, assign) CGFloat c_x;
@property (nonatomic, assign) CGFloat c_y;
@property (nonatomic, assign) CGFloat c_centerX;
@property (nonatomic, assign) CGFloat c_centerY;
@property (nonatomic, assign) CGFloat c_maxX;
@property (nonatomic, assign) CGFloat c_maxY;
@property (nonatomic, assign) CGFloat c_width;
@property (nonatomic, assign) CGFloat c_height;
@property (nonatomic, assign) CGPoint c_origin;
@property (nonatomic, assign) CGPoint c_center;
@property (nonatomic, assign) CGSize c_size;
@end

@implementation UIView (CardFrame)
- (CGFloat)c_x{
    return self.c_origin.x;
}
- (void)setC_x:(CGFloat)c_x{
    self.frame = CGRectMake(c_x, self.c_y, self.c_width, self.c_height);
}

- (CGFloat)c_y{
    return self.c_origin.y;
}
- (void)setC_y:(CGFloat)c_y{
    self.frame = CGRectMake(self.c_x, c_y, self.c_width, self.c_height);
}

- (CGFloat)c_centerX{
    return self.c_x + self.c_width / 2.0;
}
- (void)setC_centerX:(CGFloat)c_centerX{
    self.c_x = c_centerX - self.c_width / 2.0;
}

- (CGFloat)c_centerY{
    return self.c_y + self.c_height / 2.0;
}
- (void)setC_centerY:(CGFloat)c_centerY{
    self.c_y = c_centerY - self.c_height / 2.0;
}

- (CGFloat)c_maxX{
    return self.c_x + self.c_width;
}
- (void)setC_maxX:(CGFloat)c_maxX{
    self.c_x = c_maxX - self.c_width;
}

- (CGFloat)c_maxY{
    return self.c_y + self.c_height;
}
- (void)setC_maxY:(CGFloat)c_maxY{
    self.c_y = c_maxY - self.c_height;
}

- (CGFloat)c_width{
    return self.c_size.width;
}
- (void)setC_width:(CGFloat)c_width{
    self.frame = CGRectMake(self.c_x, self.c_y, c_width, self.c_height);
}

- (CGFloat)c_height{
    return self.c_size.height;
}
- (void)setC_height:(CGFloat)c_height{
    self.frame = CGRectMake(self.c_x, self.c_y, self.c_width, c_height);
}

- (CGPoint)c_origin{
    return self.frame.origin;
}
- (void)setC_origin:(CGPoint)c_origin{
    self.frame = CGRectMake(c_origin.x, c_origin.y, self.c_width, self.c_height);
}

- (CGPoint)c_center{
    return CGPointMake(self.c_centerX, self.c_centerY);
}
- (void)setC_center:(CGPoint)c_center{
    self.c_centerX = c_center.x;
    self.c_centerY = c_center.y;
}

- (CGSize)c_size{
    return self.frame.size;
}
- (void)setC_size:(CGSize)c_size{
    self.frame = CGRectMake(self.c_x, self.c_y, c_size.width, c_size.height);
}
@end

@implementation UITableView (CardView)
+ (void)load{
    tableCardSwizzleSelector([UITableView class], @selector(layoutSubviews), @selector(card_layoutSubviews));
    tableCardSwizzleSelector([UITableView class], @selector(endUpdates), @selector(card_endUpdates));
    tableCardSwizzleSelector([UITableView class], @selector(setContentOffset:), @selector(setCardContentOffset:));
}

- (void)setCardContentOffset:(CGPoint)contentOffset{
    [self setCardContentOffset:contentOffset];
    if (self.cardGroupDataSource) {
        [self reloadGroupCard];
    }
}

- (void)card_layoutIfNeeded{
    [self card_layoutIfNeeded];
}

- (void)card_layoutSubviews{
    [self card_layoutSubviews];
    if (self.cardGroupDataSource) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateGroupCardFrame];
        });
    }
}

- (void)card_endUpdates{
    [self card_endUpdates];
    if (self.cardGroupDataSource) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadGroupCard];
        });
    }
}


#pragma mark - SET和GET方法
- (id<TableCardGroupDataSource>)cardGroupDataSource{
    return self.property.dataSource;
}

- (void)setCardGroupDataSource:(id<TableCardGroupDataSource>)cardGroupDataSource{
    if (!cardGroupDataSource) {
        [self removeAllCardView];
    }
    self.property.dataSource = cardGroupDataSource;
}

#pragma mark - 操作

/// TODO:移除TableView组的card
/// @param section 组索引
- (void)removeCardViewForSection:(NSInteger)section{
    NSNumber *key = @(section);
    TableViewGroupCard *card = [self.property.displayings objectForKey:key];
    if (!card) {
        return;
    }
    [card.cardView removeFromSuperview];
    [self.property.displayings removeObjectForKey:key];
    card.section = TableViewGroupCardUndisplaySection;
    
    if (!card.reuseIdentifier) {
        return;
    }
    NSMutableArray *undisplayings = [self.property.undisplayCards objectForKey:card.reuseIdentifier];
    if (!undisplayings) {
        undisplayings = [NSMutableArray array];
        [self.property.undisplayCards setObject:undisplayings forKey:card.reuseIdentifier];
    }
    [undisplayings addObject:card];
}


/// TODO:移除所有的CardView
- (void)removeAllCardView{
    NSArray *displaySections = [self.property.displayings allKeys];
    for (NSNumber *section in displaySections) {
        [self removeCardViewForSection:[section integerValue]];
    }
    self.property.visibleSectionMin = TableViewGroupCardUndisplaySection;
    self.property.visibleSectionMax = TableViewGroupCardUndisplaySection;
}

/// TODO:移除范围内的CardView
/// @param range 范围
- (void)removeCardViewForRange:(NSRange)range{
    for (NSUInteger i = range.location; i < range.location + range.length; i++) {
        [self removeCardViewForSection:i];
    }
}


- (void)addCardViewForSection:(NSInteger)section{
    [self removeCardViewForSection:section];
    UIView *cardView = nil;
    if (self.cardGroupDataSource && [self.cardGroupDataSource respondsToSelector:@selector(tableView:cardViewForSection:)]) {
        cardView = [self.cardGroupDataSource tableView:self cardViewForSection:section];
    }
    if (!cardView) {
        return;
    }
    
    if (!cardView.tableViewGroupCard) {
        TableViewGroupCard *card = [[TableViewGroupCard alloc] init];
        card.cardView = cardView;
        cardView.tableViewGroupCard = card;
    }
    [self insertSubview:cardView atIndex:0];
    TableViewGroupCard *card = cardView.tableViewGroupCard;
    card.section = section;
    [self.property.displayings setObject:card forKey:@(section)];
    
    NSMutableArray *undisplayCads = nil;
    if (card.reuseIdentifier) {
        undisplayCads = [self.property.undisplayCards objectForKey:card.reuseIdentifier];
    }
    if (undisplayCads && [undisplayCads containsObject:card]) {
        [undisplayCads removeObject:card];
    }
}

/// TODO:添加范围内的卡片视图
/// @param range 范围
- (void)addCardViewForRange:(NSRange)range{
    for (NSUInteger i = range.location; i < range.location + range.length; i++) {
        [self addCardViewForSection:i];
    }
}


/// TODO:更新卡片视图frame
- (void)updateGroupCardFrame{
    if (self.property.visibleSectionMax == TableViewGroupCardUndisplaySection || self.property.visibleSectionMin == TableViewGroupCardUndisplaySection) {
        return;
    }
    for (NSInteger i = self.property.visibleSectionMin; i <= self.property.visibleSectionMax; i++) {
        UIEdgeInsets insets = UIEdgeInsetsZero;
        if (self.cardGroupDataSource && [self.cardGroupDataSource respondsToSelector:@selector(cardViewMarginForTableView:section:)]) {
            insets = [self.cardGroupDataSource cardViewMarginForTableView:self section:i];
        }
        UIView *cardView = [self.property.displayings objectForKey:@(i)].cardView;
        CGRect sectionRect = [self rectForSection:i];
        CGRect headerRect = [self rectForHeaderInSection:i];
        CGRect footerRect = [self rectForFooterInSection:i];
//        NSLog(@"sectionRect:%@ headerRect:%@ footerRect:%@",NSStringFromCGRect(sectionRect),NSStringFromCGRect(headerRect),NSStringFromCGRect(footerRect));
        cardView.frame = CGRectMake(insets.left, sectionRect.origin.y + headerRect.size.height-insets.top, self.c_width - insets.left - insets.right, sectionRect.size.height - headerRect.size.height - footerRect.size.height + (insets.top+insets.bottom));
    }
}

/// TODO:reload卡片式视图
- (void)reloadGroupCard{
    //获取所有可见行的位置信息
    NSArray<NSIndexPath *> *visibleIndexPaths = [self indexPathsForVisibleRows];
    if (!visibleIndexPaths.count) {
        [self removeAllCardView];
        return;
    }
    NSInteger minSection = [visibleIndexPaths firstObject].section;
    NSInteger maxSection = [visibleIndexPaths lastObject].section;
    
    if (self.property.visibleSectionMin == TableViewGroupCardUndisplaySection && self.property.visibleSectionMax == TableViewGroupCardUndisplaySection) {   // 第一次
        [self addCardViewForRange:NSMakeRange(minSection, maxSection - minSection + 1)];
    }else{
        if (minSection < self.property.visibleSectionMin) {
            [self addCardViewForRange:NSMakeRange(minSection, self.property.visibleSectionMin - minSection)];
        }else if (minSection > self.property.visibleSectionMin){
            [self removeCardViewForRange:NSMakeRange(self.property.visibleSectionMin, minSection - self.property.visibleSectionMin)];
        }
        
        if (maxSection < self.property.visibleSectionMax) {
            [self removeCardViewForRange:NSMakeRange(maxSection + 1, self.property.visibleSectionMax - maxSection)];
        }else if (maxSection > self.property.visibleSectionMax){
            [self addCardViewForRange:NSMakeRange(self.property.visibleSectionMax + 1, maxSection - self.property.visibleSectionMax)];
        }
    }
    self.property.visibleSectionMin = minSection;
    self.property.visibleSectionMax = maxSection;
}

#pragma mark - 公共方法

/// TODO:获取cardView
/// @param reuseIdentifier 标记
/// @param section 组索引
- (UIView *)dequeueReusableGroupCardViewWithIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section{
    NSMutableArray *cards = [self.property.undisplayCards objectForKey:reuseIdentifier];
    if (!cards) {
        cards = [NSMutableArray array];
        [self.property.undisplayCards setObject:cards forKey:reuseIdentifier];
    }
    
    TableViewGroupCard *card = [cards firstObject];
    if (!card) {
        card = [[TableViewGroupCard alloc] init];
        card.reuseIdentifier = reuseIdentifier;
        Class viewClass = NULL;
        NSString *viewClassString = [self.property.registedClassDic objectForKey:reuseIdentifier];
        if (viewClassString) {
            viewClass = NSClassFromString(viewClassString);
        }
        if (!viewClass) {
#ifdef DEBUG
            NSLog(@"警告: 没有注册card，使用默认view");
#endif
            viewClass = [UIView class];
        }
        UIView *view = [[viewClass alloc] init];
        if (![view isKindOfClass:[UIView class]]) {
#ifdef DEBUG
            NSLog(@"警告: 没有注册card，使用默认view");
#endif
            view = [[UIView alloc] init];
        }
        card.cardView = view;
        [cards addObject:card];
    }
    
    return card.cardView;
}

/// TODO:注册卡片类
/// @param viewClass 卡片类
/// @param reuseIdentifier 标记
- (void)registerClass:(Class)viewClass forGroupCardViewReuseIdentifier:(NSString *)reuseIdentifier{
    NSString *classString = viewClass ? NSStringFromClass(viewClass) : nil;
    [self.property.registedClassDic setValue:classString forKey:reuseIdentifier];
}
@end
