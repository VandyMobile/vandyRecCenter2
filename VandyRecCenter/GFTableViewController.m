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

- (NSArray*) GFClassesForTable {
    if (_GFClassesForTable == nil) {
        _GFClassesForTable = @[];
    }
    return _GFClassesForTable;
}


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
    NSLog(@"Table: %@",  self.GFClassesForTable);
}

- (void) clearClasses {
    self.GFClassesForTable = @[];
}

@end


@implementation GFTableViewController

@synthesize tableView = _tableView;
@synthesize classData = _classData;

#pragma mark - Getters

- (GFTableViewClassData*) classData {
    if (_classData == nil) {
        _classData = [[GFTableViewClassData alloc] init];
    }
    
    return _classData;
}

#pragma mark - Events

- (IBAction)done:(id)sender {
    [self.classData clearClasses];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lifecycle

- (void) viewDidLoad:(BOOL)animated {
    [super viewDidAppear: animated];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationView.backgroundColor = vanderbiltGold;
}


#pragma mark - TableViewDataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"cell";
    static NSString* blankCellIdentifier = @"emptyCell";
    
    
    UITableViewCell* cell;
    
    if (self.classData.sectionCount) {
       cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier: blankCellIdentifier];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (self.classData.sectionCount) {
        [self setupTableViewForCell: cell atIndexPath: indexPath];
    } else {
        [self setupBlankTableViewCell: cell];
    }
    
    return cell;
}

- (void) setupTableViewForCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath {
    NSDictionary* class = [self.classData GFClassForIndexPath: indexPath];
    
    static NSUInteger classNameLabelTag = 1;
    static NSUInteger hoursLabelTag = 2;
    static NSUInteger instructorLabelTag = 3;
    static NSUInteger locationLabelTag = 4;
    static NSUInteger addButtonTag = 5;
    static NSUInteger blankCellTag = 6;
    
    UILabel* classNameLabel;
    UILabel* hoursLabel;
    UILabel* instructorLabel;
    UILabel* locationLabel;
    UIButton* addButton;
    UILabel* blankCellLabel;

    classNameLabel = (UILabel*) [cell viewWithTag: classNameLabelTag];
    hoursLabel = (UILabel*) [cell viewWithTag: hoursLabelTag];
    instructorLabel = (UILabel*) [cell viewWithTag: instructorLabelTag];
    locationLabel = (UILabel*) [cell viewWithTag: locationLabelTag];
    addButton = (UIButton*) [cell viewWithTag: addButtonTag];
    blankCellLabel = (UILabel*) [cell viewWithTag: blankCellTag];
    
    if (classNameLabel == nil) {
        classNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 10, 230, 30)];
        classNameLabel.tag = classNameLabelTag;
        [cell addSubview: classNameLabel];
    }
    
    if (hoursLabel == nil) {
        hoursLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 45, 200, 15)];
        hoursLabel.tag = hoursLabelTag;
        [cell addSubview: hoursLabel];
    }
    
    if (instructorLabel == nil) {
        instructorLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 65, 200, 15)];
        instructorLabel.tag = instructorLabelTag;
        [cell addSubview: instructorLabel];
    }
    
    if (locationLabel == nil) {
        locationLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 85, 200, 15)];
        locationLabel.tag = locationLabelTag;
        [cell addSubview: locationLabel];
    }
    
    if (addButton == nil) {
        addButton = [UIButton buttonWithType: UIButtonTypeContactAdd];
        addButton.frame = CGRectMake(cell.frame.size.width - 40 - 10, 120/2.f - 40/2.f, 40, 40);
        addButton.tag = addButtonTag;
        [cell addSubview: addButton];
    }
    
    if (blankCellLabel) {
        [blankCellLabel removeFromSuperview];
    }
    
    classNameLabel.text = [class objectForKey: @"className"];
    
    
    hoursLabel.text = [class objectForKey: @"timeRange"];
    hoursLabel.font = [UIFont systemFontOfSize: 12];
    hoursLabel.textColor = [UIColor blueColor];
    
    instructorLabel.text = [class objectForKey: @"instructor"];
    instructorLabel.font = [UIFont systemFontOfSize: 12];
    instructorLabel.textColor = [UIColor blueColor];
    
    locationLabel.text = [class objectForKey: @"location"];
    locationLabel.font = [UIFont systemFontOfSize: 12];
    locationLabel.textColor = [UIColor blueColor];
}

- (void) setupBlankTableViewCell: (UITableViewCell*) cell {
    static NSUInteger blankLabelTag = 6;
    
    UILabel* blankLabel = (UILabel*) [cell viewWithTag: blankLabelTag];
    
    if (blankLabel == nil) {
        blankLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        blankLabel.tag = blankLabelTag;
        [cell addSubview: blankLabel];
    }
    
    blankLabel.textAlignment = NSTextAlignmentCenter;
    blankLabel.text = @"No Group Fitness Classes";
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.classData.sectionCount) ? 110.f : 50.f;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return (self.classData.sectionCount) ? [self.classData titleForSectionAtIndex: section] : @"TRY ANOTHER DATE";
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.classData.sectionCount) ? [self.classData countForGFClassesInSectionAtIndex: section] : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return (self.classData.sectionCount) ? self.classData.sectionCount : 1;
}

@end
