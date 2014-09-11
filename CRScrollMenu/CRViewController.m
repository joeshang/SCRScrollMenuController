//
//  CRViewController.m
//  CRScrollMenu
//
//  Created by Joe Shang on 8/20/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRViewController.h"
#import "CRScrollMenuButton.h"

@interface CRViewController ()

@property (nonatomic, strong) CRScrollMenu *menu;

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *titles = [NSArray arrayWithObjects:@"测试一", @"测试二", @"测试三", @"测试四", @"测试五", @"测试六", @"测试七", nil];
    NSDictionary *normalAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20],
                                       NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSDictionary *selectedAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:22],
                                         NSForegroundColorAttributeName: [UIColor yellowColor]};
    NSMutableArray *itemViews = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSString *title in titles)
    {
        CGRect buttonRect = CGRectZero;
        CGSize size = [title sizeWithAttributes:selectedAttributes];
        buttonRect.size = size;
        CRScrollMenuButton *button = [[CRScrollMenuButton alloc] initWithFrame:buttonRect];
        button.normalTitleAttributes = normalAttributes;
        button.selectedTitleAttributes = selectedAttributes;
        [button setTitle:title forState:UIControlStateNormal];
        [itemViews addObject:button];
    }
    CGRect rect = CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 60);
    self.menu = [[CRScrollMenu alloc] initWithFrame:rect andItemViews:itemViews];
    self.menu.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.menu.backgroundImage = [UIImage imageNamed:@"scrollmenu_background"];
    self.menu.delegate = self;
    
    [self.view addSubview:self.menu];
}

- (void)scrollMenu:(CRScrollMenu *)scrollMenu didSelectedAtIndex:(NSUInteger)index
{
    NSLog(@"scroll menu selected at index: %ld", index);
}

- (IBAction)onAddButtonClicked:(id)sender
{
    CGRect buttonRect = CGRectZero;
    buttonRect.size.width = 100;
    CRScrollMenuButton *button = [[CRScrollMenuButton alloc] initWithFrame:buttonRect];
    [button setTitle:@"测试增" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    [self.menu insertObject:button inItemViewsAtIndex:0];
}

- (IBAction)onRemoveButtonClicked:(id)sender
{
    [self.menu removeObjectFromItemViewsAtIndex:0];
}

@end
