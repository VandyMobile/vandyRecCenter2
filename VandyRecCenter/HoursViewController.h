//
//  HoursViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMInfinitePagerDelegate.h"
#import "Hours.h"
#import "TimeString.h"
#import "MBProgressHUD.h"
#import "NSDate+DateHelper.h"
#import "DateHelper.h"

@class BMInfinitePager;
@class BMArrowButton;

@interface HoursViewController : UIViewController <BMInfinitePagerDelegate>

// True if hours have been loaded
@property (nonatomic, assign) BOOL didLoadData;

@property (nonatomic, strong) BMInfinitePager* pager;

@property (nonatomic, strong) BMArrowButton* leftButton;
@property (nonatomic, strong) BMArrowButton* rightButton;

@property (nonatomic, strong) UIButton* todayButton;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UILabel* dayOfWeekLabel;

@property (nonatomic, strong) Hours *hours;

// helpers
- (NSString *) timeIntervalStringValueWithHours:(NSInteger)hours andMinutes:(NSInteger)minutes;

@end
