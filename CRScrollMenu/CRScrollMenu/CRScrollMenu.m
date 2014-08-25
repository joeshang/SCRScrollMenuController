//
//  CRScrollMenu.m
//  CRScrollMenu
//
//  Created by Joe Shang on 8/20/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRScrollMenu.h"

#define kCRScrollMenuButtonPaddingX         8.0
#define kCRScrollMenuIndicatorHeight        4.0
#define kCRScrollMenuScrollAnimationTime    0.3

@interface CRScrollMenu()

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation CRScrollMenu

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame andItemViews:(NSArray *)itemViews
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _currentIndex = 0;
        
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        _itemViews = [NSMutableArray arrayWithArray:itemViews];
        for (CRScrollMenuButton *itemView in itemViews)
        {
            [_contentView addSubview:itemView];
            [itemView addTarget:self
                         action:@selector(onItemViewClicked:)
               forControlEvents:UIControlEventTouchUpInside];
        }
        
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor redColor];
        [_contentView addSubview:_indicatorView];
        
        [self layoutItemViews];
    }
    
    return self;
}

#pragma mark -

- (void)layoutItemViews
{
    CGFloat x = kCRScrollMenuButtonPaddingX;
    NSUInteger index = 0;
    
    for (UIView *itemView in self.itemViews)
    {
        CGRect rect = itemView.frame;
        rect.origin.x = x;
        rect.origin.y = 0.0;
        rect.size.height = self.bounds.size.height;
        itemView.frame = rect;
        
        if (index == self.currentIndex)
        {
            self.indicatorView.frame = CGRectMake(rect.origin.x,
                                                  rect.origin.y + rect.size.height - kCRScrollMenuIndicatorHeight,
                                                  rect.size.width,
                                                  kCRScrollMenuIndicatorHeight);
        }
        index++;
        
        x += rect.size.width;
        x += kCRScrollMenuButtonPaddingX;
    }

    self.contentView.contentSize = CGSizeMake(x, CGRectGetHeight(self.bounds));
}

- (void)insertObject:(CRScrollMenuButton *)object inItemViewsAtIndex:(NSUInteger)index
{
    [self.contentView addSubview:object];
    [object addTarget:self
               action:@selector(onItemViewClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    
    CRScrollMenuButton *currentIndexItem = [self.itemViews objectAtIndex:self.currentIndex];
    [self.itemViews insertObject:object atIndex:index];
    self.currentIndex = [self.itemViews indexOfObjectIdenticalTo:currentIndexItem];
    
    [self layoutItemViews];
}

- (void)removeObjectFromItemViewsAtIndex:(NSUInteger)index
{
    [[self.itemViews objectAtIndex:index] removeFromSuperview];
    
    CRScrollMenuButton *currentIndexItem = [self.itemViews objectAtIndex:self.currentIndex];
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

#pragma mark - action

- (void)scrollToIndex:(NSUInteger)index
{
    CGRect rect = [[self.itemViews objectAtIndex:index] frame];
    
    CGPoint contentOffset = self.contentView.contentOffset;
    if (CGRectGetMinX(rect) < contentOffset.x)
    {
        contentOffset.x = CGRectGetMinX(rect);
    }
    else if (CGRectGetMaxX(rect) > contentOffset.x + self.bounds.size.width)
    {
        contentOffset.x += CGRectGetMaxX(rect) - contentOffset.x - self.bounds.size.width;
    }
    [UIView animateWithDuration:kCRScrollMenuScrollAnimationTime animations:^{
        _contentView.contentOffset = contentOffset;
    }];
    
    if (index != self.currentIndex)
    {
        CGRect indicatorRect = CGRectMake(rect.origin.x,
                                          rect.origin.y + rect.size.height - kCRScrollMenuIndicatorHeight,
                                          rect.size.width,
                                          kCRScrollMenuIndicatorHeight);
        [UIView animateWithDuration:kCRScrollMenuScrollAnimationTime animations:^{
            _indicatorView.frame = indicatorRect;
        }];
        
        self.currentIndex = index;
    }
}

- (void)onItemViewClicked:(id)sender
{
    NSUInteger index = [self.itemViews indexOfObjectIdenticalTo:sender];
    
    NSLog(@"clicked at index: %ld", index);
    
    [self scrollToIndex:index];
    
    if (index != self.currentIndex)
    {
        if (self.delegate
            && [self.delegate performSelector:@selector(scrollMenu:didSelectedAtIndex:)])
        {
            [self.delegate scrollMenu:self didSelectedAtIndex:index];
        }
    }
}

#pragma mark - getter & setter

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (_backgroundImageView == nil)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self insertSubview:_backgroundImageView belowSubview:self.contentView];
    }
    
    _backgroundImage = backgroundImage;
    _backgroundImageView.image = backgroundImage;
}

@end
