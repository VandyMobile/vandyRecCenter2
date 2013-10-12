//
//  GFTableViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface GFTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* GFClassesToDisplay;

@end
