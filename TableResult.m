//
//  TableResult.m
//  Office
//
//  Created by Administrator on 7/29/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "TableResult.h"
#import "ViewController.h"

@implementation TableResult

@synthesize mainTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    if (screenHeight == 480)
    {
        mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height-70) style:UITableViewStylePlain];
    }
    else
    {
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    }
    
    mainTable.dataSource = self;
    mainTable.delegate = self;
    
    mainTable.scrollEnabled = YES;
        
    [self addSubview:mainTable];
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.frame.size.width, 50)];
    [bar setBackgroundColor:[UIColor blackColor]];
    [self addSubview:bar];

    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(comeBackButton)];

    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"RESULT"];
    navigItem.leftBarButtonItem = back;
    bar.items = [NSArray arrayWithObjects:navigItem, nil];
    
}

-(void)comeBackButton
{
    [self removeFromSuperview];
    [ViewController removeObjectsFromOutListOfVisitors];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    cell.textLabel.text =[[ViewController getListOfVisitors] objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3)
    {
        cell.textLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:36.0];
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    [cell.textLabel sizeToFit];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
    CGSize labelSize = CGSizeMake(200.0, 20.0);
    
    labelSize = [[[ViewController getListOfVisitors] objectAtIndex:0] sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:CGSizeMake(labelSize.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return (labelSize.height + 120);
    }
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[ViewController getListOfVisitors]count];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
