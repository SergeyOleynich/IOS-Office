//
//  TableResult.h
//  Office
//
//  Created by Administrator on 7/29/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableResult : UIView <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
{
    UITableView *mainTable;
}

@property (nonatomic , retain) UITableView *mainTable;

@end
