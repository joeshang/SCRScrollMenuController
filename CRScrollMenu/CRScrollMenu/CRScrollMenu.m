//
//  CRScrollMenu.m
//  CRScrollMenu
//
//  Created by Joe Shang on 8/20/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRScrollMenu.h"

#define kCRScrollMenuButtonPaddingX                 8.0
#define kCRScrollMenuScrollAnimationTime            0.3
#define kCRScrollMenuIndicatorHeight                4.0
#define kCRScrollMenuIndicatorColor                 [UIColor colorWithRed:255 green:0 blue:0 alpha:1]

@interface CRScrollMenu()

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation CRScrollMenu

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonSetup];
        
        _itemViews = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andItemViews:(NSMutableArray *)itemViews
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonSetup];
        
        [self setItemViews:itemViews];
    }
    
    return self;
}

- (void)commonSetup
{
    _currentIndex = 0;
    
    _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = kCRScrollMenuIndicatorColor;
    _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_contentView addSubview:_indicatorView];
}

#pragma mark - view related

- (void)layoutItemViews
{
    CGFloat x = kCRScrollMenuButtonPaddingX;
    
    for (UIView *itemView in self.itemViews)
    {
        CGRect rect = itemView.frame;
        rect.origin.x = x;
        rect.origin.y = 0.0;
        rect.size.height = self.bounds.size.height;
        itemView.frame = rect;
        
        x += rect.size.width;
        x += kCRScrollMenuButtonPaddingX;
    }

    [self setIndicatorAtIndex:self.currentIndex];
    self.contentView.contentSize = CGSizeMake(x, CGRectGetHeight(self.bounds));
}

- (void)setIndicatorAtIndex:(NSUInteger)index
{
    if ([self.itemViews count] == 0)
    {
        self.indicatorView.frame = CGRectZero;
    }
    else
    {
        CGRect rect = [[self.itemViews objectAtIndex:index] frame];
        CGRect indicatorRect = CGRectMake(rect.origin.x,
                                          rect.origin.y + rect.size.height - kCRScrollMenuIndicatorHeight,
                                          rect.size.width,
                                          kCRScrollMenuIndicatorHeight);
        self.indicatorView.frame = indicatorRect;
    }
}

- (void)moveItemFromIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex
{
    // 修改item的显示状态
    [[self.itemViews objectAtIndex:oldIndex] setSelected:NO];
    [[self.itemViews objectAtIndex:newIndex] setSelected:YES];
    
    // 调整indicatorView，使其指向对应item
    [self setIndicatorAtIndex:newIndex];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (_backgroundImageView == nil)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:_backgroundImageView belowSubview:self.contentView];
    }
    
    _backgroundImage = backgroundImage;
    _backgroundImageView.image = backgroundImage;
}

#pragma mark - action

- (void)scrollToIndex:(NSUInteger)index
{
    CGRect rect = [[self.itemViews objectAtIndex:index] frame];
    
    CGPoint contentOffset = self.contentView.contentOffset;
    if (CGRectGetMinX(rect) < contentOffset.x)
    {
        contentOffset.x = CGRectGetMinX(rect) - kCRScrollMenuButtonPaddingX;
    }
    else if (CGRectGetMaxX(rect) > contentOffset.x + self.bounds.size.width)
    {
        contentOffset.x += CGRectGetMaxX(rect) - contentOffset.x - self.bounds.size.width + kCRScrollMenuButtonPaddingX;
    }
    [UIView animateWithDuration:kCRScrollMenuScrollAnimationTime animations:^{
        self.contentView.contentOffset = contentOffset;
    }];
    
    [UIView animateWithDuration:kCRScrollMenuScrollAnimationTime animations:^{
        [self moveItemFromIndex:self.currentIndex toIndex:index];
    }];
    
    self.currentIndex = index;
}

- (void)onItemViewClicked:(id)sender
{
    NSUInteger index = [self.itemViews indexOfObjectIdenticalTo:sender];
    
    [self scrollToIndex:index];
    
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(scrollMenu:didSelectedAtIndex:)])
    {
        [self.delegate scrollMenu:self didSelectedAtIndex:index];
    }
}

#pragma mark - object management

- (void)insertObject:(UIControl *)object inItemViewsAtIndex:(NSUInteger)index
{
    [self setupItemView:object];
    
    if ([self.itemViews count] == 0)
    {
        [self.itemViews addObject:object];
    }
    else
    {
        UIControl *currentIndexItem = [self.itemViews objectAtIndex:self.currentIndex];
        [self.itemViews insertObject:object atIndex:index];
        self.currentIndex = [self.itemViews indexOfObjectIdenticalTo:currentIndexItem];
    }
    
    [self layoutItemViews];
}

- (void)removeObjectFromItemViewsAtIndex:(NSUInteger)index
{
    if ([self.itemViews count] == 0)
    {
        return;
    }
    
    [[self.itemViews objectAtIndex:index] removeFromSuperview];
    
    UIControl *currentIndexItem = [self.itemViews objectAtIndex:self.currentIndex];
    [self.itemViews removeObjectAtIndex:index];
    if (index == self.currentIndex)
    {
        self.currentIndex = 0;
    }
    else
    {
        self.currentIndex = [self.itemViews indexOfObjectIdenticalTo:currentIndexItem];
    }
    
    [self layoutItemViews];
}

- (void)setItemViews:(NSMutableArray *)itemViews
{
    if (_itemViews != nil)
    {
        for (UIControl *itemView in _itemViews)
        {
            [itemView removeFromSuperview];
        }
    }
    
    self.currentIndex = 0;
    
    _itemViews = [NSMutableArray arrayWithArray:itemViews];
    for (UIControl *itemView in itemViews)
    {
        [self setupItemView:itemView];
    }
    [[_itemViews objectAtIndex:self.currentIndex] setSelected:YES];
    
    [self layoutItemViews];
}

- (void)setupItemView:(UIControl *)itemView
{
    itemView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [itemView addTarget:self
                 action:@selector(onItemViewClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:itemView];
}

@end
