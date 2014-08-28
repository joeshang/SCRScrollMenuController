//
//  CRScrollMenuButton.m
//  CRScrollMenu
//
//  Created by Joe Shang on 8/24/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRScrollMenuButton.h"

@implementation CRScrollMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
    }
    
    return self;
}

- (void)setNormalTitleAttributes:(NSDictionary *)normalTitleAttributes
{
    _normalTitleAttributes = normalTitleAttributes;
    [self setTitleColor:normalTitleAttributes[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    if (self.isSelected == NO)
    {
        self.titleLabel.font = normalTitleAttributes[NSFontAttributeName];
    }
}

- (void)setSelectedTitleAttributes:(NSDictionary *)selectedTitleAttributes
{
    _selectedTitleAttributes = selectedTitleAttributes;
    [self setTitleColor:selectedTitleAttributes[NSForegroundColorAttributeName] forState:UIControlStateSelected];
    if (self.isSelected == YES)
    {
        self.titleLabel.font = selectedTitleAttributes[NSFontAttributeName];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        if (self.selectedTitleAttributes[NSFontAttributeName])
        {
            self.titleLabel.font = self.selectedTitleAttributes[NSFontAttributeName];
        }
    }
    else
    {
        if (self.normalTitleAttributes[NSFontAttributeName])
        {
            self.titleLabel.font = self.normalTitleAttributes[NSFontAttributeName];
        }
    }
}

@end
