//
//  GroupFitnessViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/5/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZDayPicker.h"

@interface GroupFitnessViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, weak) IBOutlet MZDayPicker* dayPicker;

@end
