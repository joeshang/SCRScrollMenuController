//
//  CRViewController.m
//  CRScrollMenuController
//
//  Created by Joe Shang on 9/10/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import "CRViewController.h"
#import "CRScrollMenuController.h"

@interface CRViewController ()

@property (nonatomic, strong) CRScrollMenuController *scrollMenuController;

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollMenuController = [[CRScrollMenuController alloc] init];
    self.scrollMenuController.scrollMenuHeight = 60;
    self.scrollMenuController.scrollMenuBackgroundImage = [UIImage imageNamed:@"scrollmenu_background"];
    self.scrollMenuController.scrollMenuIndicatorColor = [UIColor whiteColor];
    self.scrollMenuController.scrollMenuIndicatorHeight = 4;
    self.scrollMenuController.scrollMenuButtonPadding = 20;
    self.scrollMenuController.normalTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:19],
                                                        NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    self.scrollMenuController.selectedTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:21],
                                                        NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    self.scrollMenuController.normalSubtitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                                        NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    self.scrollMenuController.selectedSubtitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                                        NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    
    [self addChildViewController:self.scrollMenuController];
    self.scrollMenuController.view.frame = CGRectMake(0, 40, CGRectGetWidth(self.view.bounds), 500);
    self.scrollMenuController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scrollMenuController.view];
    [self.scrollMenuController didMoveToParentViewController:self];
    
    NSArray *titles = @[@"红色", @"橙色", @"黄色", @"绿色", @"青色", @"蓝色", @"紫色"];
    NSArray *colors = @[[UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor cyanColor],
                        [UIColor blueColor],
                        [UIColor purpleColor]];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:[titles count]];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:[titles count]];
    
    for (NSUInteger i = 0; i < [titles count]; i++)
    {
        UIViewController *controller = [[UIViewController alloc] init];
        controller.view.backgroundColor = [colors objectAtIndex:i];
        [viewControllers addObject:controller];
        
        CRScrollMenuItem *item = [[CRScrollMenuItem alloc] init];
        item.title = [titles objectAtIndex:i];
        item.subtitle = [titles objectAtIndex:i];
        [items addObject:item];
    }
    [self.scrollMenuController setViewControllers:viewControllers withItems:items];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
