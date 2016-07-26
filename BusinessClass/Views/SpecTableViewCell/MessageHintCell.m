//
//  MessageHintCell.m
//  LoanService
//
//  Created by very good on 15/3/10.
//  Copyright (c) 2015年 zonxt. All rights reserved.
//

#import "MessageHintCell.h"

@implementation MessageHintCell

+(UITableViewCell *)getMessageHintCell:(UITableView *)tableView
{
    return   [MessageHintCell getMessageHintCell:tableView message:@"暂无记录"];
}

+(UITableViewCell *)getMessageHintCell:(UITableView *)tableView message:(NSString *)message
{
    MessageHintCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageHintCellIdentifier"];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MessageHintCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[MessageHintCell class]]) {
                cell = (MessageHintCell *)o;
                break;
            }
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.message.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    cell.message.font = [UIFont systemFontOfSize:13.0];
    cell.message.text = message;
    
    return cell;
}


@end
