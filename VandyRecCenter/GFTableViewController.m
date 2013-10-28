//
//  GFTableViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFTableViewController.h"
#import "MBProgressHUD.h"


@interface GFTableViewClassData()

@property (nonatomic, strong) NSArray* GFClassesForTable;

@end

@implementation GFTableViewClassData

@synthesize sectionCount = _sectionCount;
@synthesize GFClassesForTable = _GFClassesForTable;

- (NSUInteger) sectionCount {
    return _GFClassesForTable.count;
}

- (NSUInteger) countForGFClassesInSectionAtIndex: (NSUInteger) index {
    return [[_GFClassesForTable[index] objectForKey: @"GFClasses"] count];
}
- (NSString*) titleForSectionAtIndex: (NSUInteger) index {
    return [_GFClassesForTable[index] objectForKey: @"title"];
}
- (NSDictionary*) GFClassForIndexPath: (NSIndexPath*) indexPath {
    NSArray* GFClasses = [_GFClassesForTable[indexPath.section] objectForKey: @"GFClasses"];
    return GFClasses[indexPath.row];
}

- (void) pushGFClasses: (NSArray*) GFClasses withTitle: (NSString*) title {
    NSDictionary* newEntry = @{@"title": title, @"GFClasses": GFClasses};
    self.GFClassesForTable = [_GFClassesForTable arrayByAddingObject: newEntry];
}

- (void) clearClasses {
    self.GFClassesForTable = @[];
}

@end


@implementation GFTableViewController


#pragma mark - Lifecycle

- (void) viewDidLoad:(BOOL)animated {
    [super viewDidAppear: animated];
}
#pragma mark - TableViewDataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = self.GFClassesToDisplay.count;
    NSLog(@"Count is %i", count);
    if (count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noDataCell"];
        [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
        [[cell textLabel] setTextColor:[UIColor colorWithWhite:0.2 alpha:0.8]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if ([indexPath row] == 1) {
            [[cell textLabel] setText:NSLocalizedString(@"No Group Fitness Classes", @"A label for a table with no Group Fitness Classes.")];
        }
        else
        {
            [[cell textLabel] setText:@""];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //count > 0 here
    NSDictionary* GFClass = [self.GFClassesToDisplay objectAtIndex: indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"groupFitnessCell"];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed: @"GroupFitnessCell" owner: self options:nil];
        cell = [nib objectAtIndex: 0];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"groupFitnessCell"];
    }
    [(UILabel*)[cell viewWithTag: CELL_CLASSNAME_LABEL] setText: [GFClass objectForKey: @"className" ]];
    [(UILabel*)[cell viewWithTag: CELL_INSTRUCTOR_LABEL] setText: [GFClass objectForKey: @"instructor" ]];
    
    UILabel* timeRangeLabel =  (UILabel*) [cell viewWithTag: CELL_TIMERANGE_LABEL];
    timeRangeLabel.text = [GFClass objectForKey: @"timeRange"];
     
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, timeRangeLabel.frame.size.height - 1, timeRangeLabel.frame.size.width, 1.0f);
    topBorder.backgroundColor = [UIColor blackColor].CGColor;
    [timeRangeLabel.layer addSublayer:topBorder];
    
    
    
    UIButton* button = (UIButton*) [cell viewWithTag: CELL_ADD_BUTTON];
    //here, need to check if the goal is added or not
    button.backgroundColor = vanderbiltGold;
    button.layer.cornerRadius = 5.0f;
    [button setTitle: @"+" forState: UIControlStateNormal];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.GFClassesToDisplay.count == 0) {
        return 2;
    }
    return self.GFClassesToDisplay.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
/*
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.GFClassesToDisplay.count) {
        UIView* header = [[UIView alloc] init];
        CAGradientLayer* gradient = [[CAGradientLayer alloc] init];
        gradient.frame = CGRectMake(0, 0, self.view.frame.size.width, 24);
        gradient.colors  = @[(id) [UIColor blackColor].CGColor,(id) [UIColor darkGrayColor].CGColor];
        [header.layer insertSublayer: gradient atIndex: 0];
        
        UILabel* headerTitle = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 20)];
        
        headerTitle.textColor = [UIColor whiteColor];
        headerTitle.font = [UIFont systemFontOfSize: 12];
        headerTitle.textAlignment = NSTextAlignmentCenter;
        headerTitle.backgroundColor = [UIColor clearColor];
        headerTitle.text = [[self.GFClassesToDisplay objectAtIndex: section] objectForKey: @"timeRange"];
        [header addSubview: headerTitle];
        
        return header;
    }
    return  nil;
}
 */

#pragma mark - TableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
