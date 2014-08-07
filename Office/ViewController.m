//
//  ViewController.m
//  Office
//
//  Created by Administrator on 7/23/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "ViewController.h"
#import "TableResult.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize listOfVisitors;

static NSMutableArray *firstArray;

bool isAddButtonEnabled = YES;
NSNumber *translateFromHourToMinute;
NSSet *week;
NSString *dayOfTheWeek;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    firstArray = [NSMutableArray new];
    
    listOfVisitors = [NSMutableArray new];
    
    translateFromHourToMinute = [NSNumber numberWithInt:60];
    self.outButtom.enabled = NO;
    
    week = [NSSet setWithObjects:@"MONDAY", @"THUESDAY", @"WEDNESDAY", @"THURSDAY", @"FRIDAY", @"SATURDAY", @"SUNDAY", nil];
    
        
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushNewDayButton:(id)sender
{
    UIAlertView *newDayAlertView = [[UIAlertView alloc]initWithTitle:@"Choose the day"
                                                             message:NULL
                                                            delegate:self
                                                   cancelButtonTitle:@"CANCEL"
                                                   otherButtonTitles:@"MONDAY", @"THUESDAY", @"WEDNESDAY", @"THURSDAY", @"FRIDAY", @"SATURDAY", @"SUNDAY", nil];
    newDayAlertView.alertViewStyle = UIAlertViewStyleDefault;
    newDayAlertView.tag = 101;
    [newDayAlertView show];
    
}

- (IBAction)pushIncomingButtonForPerson:(id)sender
{
    UIAlertView *incomingAlertView = [[UIAlertView alloc]initWithTitle:@"Put incoming time"
                                                               message:NULL
                                                              delegate:self
                                                     cancelButtonTitle:@"CANCEL"
                                                     otherButtonTitles:@"DONE", nil];
    incomingAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [incomingAlertView textFieldAtIndex:0].placeholder = @"HOUR (push from 0 to 23)";
    [incomingAlertView textFieldAtIndex:1].placeholder = @"MINUTE (push from 0 to 59)";
    [[incomingAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[incomingAlertView textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeDecimalPad];
    [incomingAlertView textFieldAtIndex:0].textAlignment = NSTextAlignmentCenter;
    [incomingAlertView textFieldAtIndex:1].textAlignment = NSTextAlignmentCenter;
    [[incomingAlertView textFieldAtIndex:1] setSecureTextEntry:NO];
    incomingAlertView.tag = 201;
    [incomingAlertView show];
}

- (IBAction)pushOutcomingTimeForPerson:(id)sender
{
    UIAlertView *outcomingAlertView = [[UIAlertView alloc]initWithTitle:@"Put outcoming time"
                                                                message:NULL
                                                               delegate:self
                                                      cancelButtonTitle:@"CANCEL"
                                                      otherButtonTitles:@"DONE", nil];
    outcomingAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [outcomingAlertView textFieldAtIndex:0].placeholder = @"HOUR (push from 0 to 23)";
    [outcomingAlertView textFieldAtIndex:1].placeholder = @"MINUTE (push from 0 to 59)";
    [[outcomingAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDecimalPad];
    [[outcomingAlertView textFieldAtIndex:1] setKeyboardType:UIKeyboardTypeDecimalPad];
    [outcomingAlertView textFieldAtIndex:0].textAlignment = NSTextAlignmentCenter;
    [outcomingAlertView textFieldAtIndex:1].textAlignment = NSTextAlignmentCenter;
    [[outcomingAlertView textFieldAtIndex:1] setSecureTextEntry:NO];
    outcomingAlertView.tag = 301;
    [outcomingAlertView show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([week containsObject:title]) {
        [_labelForDay setText:title];
        dayOfTheWeek = title;
    }
    if ([title isEqualToString:@"DONE"]) {
        UITextField *hour;
        NSNumber *hourInteger;
        UITextField *minute;
        NSNumber *minuteInteger;
        NSNumber *commonIncomingTime;
        if (alertView.tag == 201)
        {
            self.outButtom.enabled = YES;
            isAddButtonEnabled = NO;
            self.addButton.enabled = NO;
            hour = [alertView textFieldAtIndex:0];
            hourInteger = [NSNumber numberWithInteger:[hour.text integerValue]];
            minute = [alertView textFieldAtIndex:1];
            minuteInteger = [NSNumber numberWithInteger:[minute.text integerValue]];
            commonIncomingTime = [NSNumber numberWithInt:([hourInteger intValue] * [translateFromHourToMinute intValue] + [minuteInteger intValue])];
        }
        else if (alertView.tag == 301)
        {
            self.addButton.enabled = YES;
            isAddButtonEnabled = YES;
            self.outButtom.enabled = NO;
            hour = [alertView textFieldAtIndex:0];
            hourInteger = [NSNumber numberWithInteger:[hour.text integerValue]];
            minute = [alertView textFieldAtIndex:1];
            minuteInteger = [NSNumber numberWithInteger:[minute.text integerValue]];
            commonIncomingTime = [NSNumber numberWithInt:-([hourInteger intValue] * [translateFromHourToMinute intValue] + [minuteInteger intValue])];
        }
            [listOfVisitors addObject:commonIncomingTime];
        }
        else if ([title isEqualToString:@"CANCEL"])
        {
            NSLog(@"CANCEL");
        }
}

//-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
//{
//    NSString *inputTextHour = [[alertView textFieldAtIndex:0] text];
//    if (alertView.tag == 201 || alertView.tag == 301)
//    {
//    if ([inputTextHour length] >=1)
//    {
//        NSString *inputTextMinute = [[alertView textFieldAtIndex:1] text];
//        if ([inputTextMinute length] >= 2) {
//            return YES;
//        }
//        else
//        {
//            return NO;
//        }
//    }
//    else
//    {
//        return NO;
//    }
//    }
//    else
//    {
//        return YES;
//    }
//}

- (IBAction)getResultButton:(id)sender
{
    // sort NSMutableArray listOfVisitors
    for (int i = 0; i < [listOfVisitors count]; i++)
    {
        for (int j = 0; j < [listOfVisitors count]-1; j++)
        {
            if (abs([[listOfVisitors objectAtIndex:j] integerValue]) > abs([[listOfVisitors objectAtIndex:j+1]integerValue]))
            {
                NSNumber *k = [listOfVisitors objectAtIndex:j];
                [listOfVisitors replaceObjectAtIndex:j withObject:[listOfVisitors objectAtIndex:j+1]];
                [listOfVisitors replaceObjectAtIndex:j+1 withObject:k];
            }
        }
    }
    // считаем количество максимально присутствующих людей одновременно за день и вывести их время
    int currentVisitor = 0;
    int maxVisitor = 0;
    NSNumber *incomingTime;
    NSNumber *outcomingTime;
    NSMutableArray *incomingTimeArray = [NSMutableArray new];
    NSMutableArray *outcomingTimeArray = [NSMutableArray new];
    for (int i = 0; i < [listOfVisitors count]; i++)
    {
        if ([listOfVisitors [i] integerValue] > 0)
        {
            currentVisitor ++;
        }
        else
        {
            currentVisitor --;
        }
        if (maxVisitor < currentVisitor)
        {
            maxVisitor = currentVisitor;
        }
        else if (maxVisitor == currentVisitor + 1 && [listOfVisitors [i-1] integerValue] > 0)
        {
            incomingTime = [NSNumber numberWithInt:[listOfVisitors [i-1] integerValue]];
            outcomingTime = [NSNumber numberWithInt:[listOfVisitors [i] integerValue]];
            [incomingTimeArray addObject:incomingTime];
            [outcomingTimeArray addObject:outcomingTime];
        }
    }
    // перевести время из минутного формата в формат вида 8:00
    NSString *incomingTimeNormalFormat;
    NSString *outcomingTimeNormalFormat;
    NSMutableArray *incomingTimeNormalFormatArray = [NSMutableArray new];
    for (int i = 0; i < [incomingTimeArray count]; i++)
    {
        NSNumber *currentTime = [NSNumber numberWithFloat:([incomingTimeArray [i] floatValue]/[translateFromHourToMinute floatValue])];
        int integerHour = [currentTime integerValue];
        int integerMinute = ([currentTime floatValue] - integerHour)*[translateFromHourToMinute floatValue];
        if (integerMinute == 0)
        {
            incomingTimeNormalFormat = [NSString stringWithFormat:@"%d : %d%d", integerHour, integerMinute, integerMinute];
        }
        else
        {
        incomingTimeNormalFormat = [NSString stringWithFormat:@"%d : %d", integerHour, integerMinute];
        }
        [incomingTimeNormalFormatArray addObject:incomingTimeNormalFormat];
    }
    NSMutableArray *outcomingTimeNormalFormatArray = [NSMutableArray new];
    for (int i = 0; i < [incomingTimeArray count]; i++)
    {
        NSNumber *currentTime = [NSNumber numberWithFloat:([outcomingTimeArray [i] floatValue]/[translateFromHourToMinute floatValue])];
        int integerHour = -[currentTime integerValue];
        int integerMinute = ([currentTime floatValue] - (-integerHour))*[translateFromHourToMinute floatValue];
        if (integerMinute == 0)
        {
            outcomingTimeNormalFormat = [NSString stringWithFormat:@"%d : %d%d", integerHour, integerMinute, integerMinute];
        }
        else
        {
        outcomingTimeNormalFormat = [NSString stringWithFormat:@"%d : %d", integerHour, integerMinute];
        }
        [outcomingTimeNormalFormatArray addObject:outcomingTimeNormalFormat];
    }
    NSMutableArray *globalTimeIntervalArray = [NSMutableArray new];
    for (int i = 0; i < [incomingTimeNormalFormatArray count]; i++)
    {
        NSString *globalTimeinterval = [NSString stringWithFormat:@"%@ - %@", incomingTimeNormalFormatArray [i], outcomingTimeNormalFormatArray [i]];
        [globalTimeIntervalArray addObject:globalTimeinterval];
    }
    //на первое место массива запихнуть число = максимальному количеству людей
    NSString *objectMaxVisitor = [NSString stringWithFormat:@"%d", maxVisitor];
    [firstArray addObject:dayOfTheWeek];
    [firstArray addObject:@"Max Visitors in office by the same time"];
    [firstArray addObject:objectMaxVisitor];
    [firstArray addObject:@"Period of time"];
    [firstArray addObjectsFromArray:globalTimeIntervalArray];
    
    TableResult *tableResult = [[NSBundle mainBundle] loadNibNamed:@"TableResult" owner:self options:nil][0];
    [self.view addSubview:tableResult];

}

+(void) removeObjectsFromOutListOfVisitors
{
    [firstArray removeAllObjects];
}

+(NSMutableArray*) getListOfVisitors
{
    return firstArray;
}



@end
