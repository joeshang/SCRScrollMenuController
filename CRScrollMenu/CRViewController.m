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
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:titles.count];
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger index, BOOL *stop){
        CRScrollMenuItem *item = [[CRScrollMenuItem alloc] init];
        item.title = title;
        item.subtitle = [NSString stringWithFormat:@"subtitle%ld", index + 1];
        [items addObject:item];
    }];
    CGRect rect = CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 60);
    self.menu = [[CRScrollMenu alloc] initWithFrame:rect];
    self.menu.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.menu.backgroundImage = [UIImage imageNamed:@"scrollmenu_background"];
    self.menu.delegate = self;
    self.menu.buttonPadding = 14;
    self.menu.normalTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                        NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.menu.selectedTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:20],
                                          NSForegroundColorAttributeName: [UIColor yellowColor]};
    [self.menu setButtonsByItems:items];
    [self.view addSubview:self.menu];
}

- (void)scrollMenu:(CRScrollMenu *)scrollMenu didSelectedAtIndex:(NSUInteger)index
{
    NSLog(@"scroll menu selected at index: %ld", index);
}

- (IBAction)onAddButtonClicked:(id)sender
{
    CRScrollMenuItem *item = [[CRScrollMenuItem alloc] init];
    item.title = @"测试增加";
    
    [self.menu insertButtonByItem:item atIndex:0];
}

- (IBAction)onRemoveButtonClicked:(id)sender
{
    [self.menu removeButtonAtIndex:0];
}

@end
