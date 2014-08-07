//
//  ViewController.h
//  Office
//
//  Created by Administrator on 7/23/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UIAlertViewDelegate>
{
    NSMutableArray *listOfVisitors;
}

@property (weak, nonatomic) IBOutlet UIButton *outButtom;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *resultButon;
@property (nonatomic, copy) NSMutableArray *listOfVisitors;
@property (weak, nonatomic) IBOutlet UILabel *labelForDay;

- (IBAction)pushNewDayButton:(id)sender;
- (IBAction)pushIncomingButtonForPerson:(id)sender;
- (IBAction)pushOutcomingTimeForPerson:(id)sender;
- (IBAction)getResultButton:(id)sender;

+(NSMutableArray*) getListOfVisitors;
+(void) removeObjectsFromOutListOfVisitors;


@end
