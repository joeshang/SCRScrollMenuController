//
//  CRViewController.h
//  CRScrollMenu
//
//  Created by Joe Shang on 8/20/14.
//  Copyright (c) 2014 Shang Chuanren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRScrollMenu.h"

@interface CRViewController : UIViewController
<CRScrollMenuDelegate>

- (IBAction)onAddButtonClicked:(id)sender;
- (IBAction)onRemoveButtonClicked:(id)sender;

@end
