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
        [self commonSetup];
    }
    
    return self;
}

- (void)commonSetup
{
    self.backgroundColor = [UIColor clearColor];
    
    _titlePaddingY = 0;
    _normalTitleAttributes = @{
                               NSFontAttributeName: [UIFont systemFontOfSize:17],
                               NSForegroundColorAttributeName: [UIColor redColor]
                               };
    _normalSubtitleAttributes = @{
                                  NSFontAttributeName: [UIFont systemFontOfSize:12],
                                  NSForegroundColorAttributeName: [UIColor blueColor]
                                  };
    _selectedTitleAttributes = [_normalTitleAttributes copy];
    _selectedSubtitleAttributes = [_normalSubtitleAttributes copy];
}

- (void)drawRect:(CGRect)rect
{
    CGSize titleSize = CGSizeZero;
    CGSize subtitleSize = CGSizeZero;
    NSDictionary *titleAttributes = nil;
    NSDictionary *subtitleAttributes = nil;
    
    if (self.isSelected)
    {
        titleAttributes = self.selectedTitleAttributes;
        subtitleAttributes = self.selectedSubtitleAttributes;
    }
    else
    {
        titleAttributes = self.normalTitleAttributes;
        subtitleAttributes = self.normalSubtitleAttributes;
    }
    
    if (self.title && [self.title length])
    {
        titleSize = [self.title boundingRectWithSize:self.bounds.size
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:titleAttributes
                                             context:nil].size;
        
        if (self.subtitle && [self.subtitle length])
        {
            subtitleSize = [self.subtitle boundingRectWithSize:self.bounds.size
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:subtitleAttributes
                                                       context:nil].size;
            float y = roundf((self.bounds.size.height - titleSize.height - subtitleSize.height - self.titlePaddingY) / 2);
            [self.title drawInRect:CGRectMake(roundf((self.bounds.size.width - titleSize.width) / 2),
                                              y,
                                              titleSize.width,
                                              titleSize.height)
                    withAttributes:titleAttributes];
            [self.subtitle drawInRect:CGRectMake(roundf((self.bounds.size.width - subtitleSize.width) / 2),
                                                 y + titleSize.height + self.titlePaddingY,
                                                 subtitleSize.width,
                                                 subtitleSize.height)
                       withAttributes:subtitleAttributes];
        }
        else
        {
            [self.title drawInRect:CGRectMake(roundf((self.bounds.size.width - titleSize.width) / 2),
                                              roundf((self.bounds.size.height - titleSize.height) / 2),
                                              titleSize.width,
                                              titleSize.height)
                    withAttributes:titleAttributes];
            
        }
    }
}

@end
