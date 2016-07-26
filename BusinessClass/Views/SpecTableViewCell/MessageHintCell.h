//
//  MessageHintCell.h
//  LoanService
//
//  Created by very good on 15/3/10.
//  Copyright (c) 2015年 zonxt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageHintCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *message;

+(UITableViewCell *)getMessageHintCell:(UITableView *)tableView;
+(UITableViewCell *)getMessageHintCell:(UITableView *)tableView message:(NSString *)message;

@end
