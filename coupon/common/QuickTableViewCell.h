//
//  QuickTableViewCell.h
//  coupon
//
//  Created by chijr on 16/4/30.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface QuickTableViewCell : UITableViewCell

typedef void(^LayoutBlock)(QuickTableViewCell *theCell);
typedef void(^UpdateBlock)(QuickTableViewCell *theCell);


@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UILabel *tailLabel;
@property(nonatomic,strong)UILabel *dateTimeLabel;

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,copy)LayoutBlock layoutBlock;
@property(nonatomic,copy)UpdateBlock updateBlock;


-(void)updateData;




@end
