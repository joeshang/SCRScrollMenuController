//
//  CRViewController.m
//  CRScrollMenu
//
//  Created by Joe Shang on 8/20/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRViewController.h"
#import "CRScrollMenu.h"

@interface CRViewController ()

@property (nonatomic, strong) CRScrollMenu *menu;

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *titles = [NSArray arrayWithObjects:@"测试一", @"测试二", @"测试三", @"测试四", @"测试五", @"测试六", @"测试七", nil];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    NSMutableArray *itemViews = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSString *title in titles)
    {
        CGRect buttonRect = CGRectZero;
        CGSize size = [title sizeWithAttributes:attributes];
        buttonRect.size = size;
        CRScrollMenuButton *button = [[CRScrollMenuButton alloc] initWithFrame:buttonRect];
        [button setTitle:title forState:UIControlStateNormal];
        [itemViews addObject:button];
    }
    CGRect rect = CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 60);
    self.menu = [[CRScrollMenu alloc] initWithFrame:rect andItemViews:itemViews];
//    self.menu.backgroundColor = [UIColor blueColor];
    self.menu.backgroundImage = [UIImage imageNamed:@"scrollmenu_background"];
    
    [self.view addSubview:self.menu];
}

- (IBAction)onAddButtonClicked:(id)sender
{
    CGRect buttonRect = CGRectZero;
    buttonRect.size.width = 100;
    CRScrollMenuButton *button = [[CRScrollMenuButton alloc] initWithFrame:buttonRect];
    [button setTitle:@"测试增" forState:UIControlStateNormal];
    
    [self.menu insertObject:button inItemViewsAtIndex:0];
}

- (IBAction)onRemoveButtonClicked:(id)sender
{
    [self.menu removeObjectFromItemViewsAtIndex:0];
}

@end
