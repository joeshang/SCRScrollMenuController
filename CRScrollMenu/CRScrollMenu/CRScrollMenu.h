//
//  CRScrollMenu.h
//  CRScrollMenu
//
//  Created by Joe Shang on 8/20/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRScrollMenu;
@protocol CRScrollMenuDelegate <NSObject>

- (void)scrollMenu:(CRScrollMenu *)scrollMenu didSelectedAtIndex:(NSUInteger)index;

@end

@interface CRScrollMenu : UIView

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSMutableArray *itemViews;
@property (nonatomic, weak)   id<CRScrollMenuDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andItemViews:(NSMutableArray *)itemViews;

- (void)insertObject:(UIControl*)object inItemViewsAtIndex:(NSUInteger)index;
- (void)removeObjectFromItemViewsAtIndex:(NSUInteger)index;

- (void)scrollToIndex:(NSUInteger)index;

@end
