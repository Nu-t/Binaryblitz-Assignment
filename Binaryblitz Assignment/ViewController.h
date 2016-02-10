//
//  ViewController.h
//  Binaryblitz Assignment
//
//  Created by Nikolay on 09.02.16.
//  Copyright © 2016 nut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *UITableView;
@property (weak, nonatomic) IBOutlet UIButton *fetchButton;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@end

