//
//  CouponPaymentDetailViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/23.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponPaymentDetailViewCtrl.h"
#import "CouponInfoTableViewCell.h"

@interface CouponPaymentDetailViewCtrl ()


@end

@implementation CouponPaymentDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"couponInfo"];
    
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    if (self.couponPaymentType == CouponPaymentTypeNoUsed) {
        self.navigationItem.title=@"未使用优惠券";
    }else{
        self.navigationItem.title=@"已经使用优惠券";
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        return nil;
        
        
    }
    

    if (section==1) {
        
        
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [GUIConfig mainBackgroundColor];
        
        UILabel *nameLabel = [UILabel new];
        
        nameLabel.frame = CGRectMake(0, 20, SCREEN_WIDTH, 30);
        nameLabel.backgroundColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text=@"   验券码";
        
        [headerView addSubview:nameLabel];
        
        return headerView;
        
        
    }

    
    if (section==2) {
        
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [GUIConfig mainBackgroundColor];
        
         return headerView;
        
    }
    
    if (section==3) {
        
        UIView *headerView = [UIView new];
        headerView.backgroundColor = [GUIConfig mainBackgroundColor];
        
        return headerView;
        
    }
    
    return nil;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section==0) {
        return 0;
    }
    if (section==2) {
        return 20;
    }

  
    if (section==3) {
        return 20;
    }
    

    return 50;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section==0) {
        return 100;
    }
    
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            
            return 40;
        }
        if (indexPath.row==1) {
            
            return 40;
        }
        
        
    }
    
    
    
    return 100;
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    // Return the number of rows in the section.
    
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([indexPath section]==0) {
        
        CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponInfo" forIndexPath:indexPath];
        
        cell.data = self.data;
        
        [cell updateData];
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
       // return cell;
        
        
 //
    }
    
    if ([indexPath section]==1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (indexPath.row==0) {
            
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            if (self.couponPaymentType == CouponPaymentTypeNoUsed) {
                cell.textLabel.textColor = [UIColor redColor];
                
            }else{
                cell.textLabel.textColor = [UIColor grayColor];
                
            }
            cell.textLabel.text=@"有效期：2016-10-01 23:59:59";
            
            return cell;
        }
  
        if (indexPath.row==1) {
            
            
            UILabel *codeLabel = [UILabel new];
            codeLabel.font = [UIFont boldSystemFontOfSize:14];
            
            //[GUIConfig grayFontColor];
            [cell.contentView addSubview:codeLabel];
            
            [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(20);
                make.right.equalTo(cell.contentView).offset(-1*SCREEN_WIDTH/3);
                make.height.equalTo(cell.contentView);
                make.centerY.equalTo(cell.contentView);
            }];
            
            codeLabel.text=@"券码:    1234 4212 3213 1234";
            
            
            UILabel *usageLabel = [UILabel new];
            usageLabel.font = [UIFont boldSystemFontOfSize:14];
            
            if (self.couponPaymentType == CouponPaymentTypeUsed) {
                usageLabel.text = @"已消费";
                usageLabel.textColor = [UIColor lightGrayColor];
                codeLabel.textColor =[UIColor lightGrayColor];
                
                
            }
            
            if (self.couponPaymentType == CouponPaymentTypeNoUsed) {
                usageLabel.text = @"未消费";
                usageLabel.textColor = [UIColor darkGrayColor];
                
                codeLabel.textColor =[UIColor darkGrayColor];
                
                
            }
            
            
            [cell.contentView addSubview:usageLabel];
            
            [usageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                
                make.left.equalTo(codeLabel.mas_right).offset(10);
                make.right.equalTo(cell.contentView);
                make.height.equalTo(cell.contentView);
                make.centerY.equalTo(cell.contentView);
                
                
            }];
            
            
            
            
            return cell;
        }

        
        
        
        
    }
    
    
    if ([indexPath section]==2) {
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
     
        [self makeAddressCell:cell];
        
        return cell;
        
    }
    
    
    if ([indexPath section]==3) {
        
        
 
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        [self makeCellComment:cell];
        
        return cell;
    }
    
    
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    return cell;
    
    
    
        
    
    
    // Configure the cell...
    
    return nil;
}



-(void)makeAddressCell:(UITableViewCell*)cell{
    
    
    UILabel *addressLabel = [UILabel new];
    
    [cell.contentView addSubview:addressLabel];
    
    addressLabel.font = [UIFont boldSystemFontOfSize:16];
    addressLabel.textColor = [GUIConfig grayFontColorDeep];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(10);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@30);
        
    }];
    
    addressLabel.text=@"正佳广场二楼";
    
    UIView *line = [GUIConfig line];
    
    [cell.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.top.equalTo(addressLabel.mas_bottom).offset(10);
        make.right.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(10);
        
        
    }];
    
    
    UIButton *callPhoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cell.contentView addSubview:callPhoneButton];
    
    [callPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.left.and.bottom.equalTo(cell.contentView);
        make.top.equalTo(line);
    }];
    
    [callPhoneButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    
    [callPhoneButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    
    UIButton *gotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [cell.contentView addSubview:gotoButton];
    
    [gotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(SCREEN_WIDTH/2);
        
        make.right.and.bottom.equalTo(cell.contentView);
        make.top.equalTo(line);
    }];
    
    [gotoButton setTitle:@"去到这里" forState:UIControlStateNormal];
    
    [gotoButton setTitleColor:[GUIConfig grayFontColorDeep] forState:UIControlStateNormal];
    
    
    
    UIView *line2 = [GUIConfig line];
    
    [cell.contentView addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@1);
        make.top.equalTo(gotoButton).offset(10);
        make.bottom.equalTo(gotoButton).offset(-10);
        make.left.equalTo(gotoButton);
        
    }];
    
    
    
    
    
    
    
    
    
}


-(void)makeCellComment:(UITableViewCell*)cell{
    
    
    UILabel *commentTitleLabel = [UILabel new];
    
    [cell.contentView addSubview:commentTitleLabel];
    
    commentTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    commentTitleLabel.textColor = [GUIConfig grayFontColorDeep];
    [commentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(cell.contentView.mas_top).with.offset(10);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@20);
        
    }];
    
    commentTitleLabel.text=@"使用说明:";
    
    UIView *line = [GUIConfig line];
    
    [cell.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@1);
        make.top.equalTo(commentTitleLabel.mas_bottom).offset(10);
        make.right.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).offset(10);
        
        
    }];
    
    
    UILabel *commentLabel = [UILabel new];
    
    [cell.contentView addSubview:commentLabel];
    
    commentLabel.font = [UIFont boldSystemFontOfSize:16];
    commentLabel.textColor = [GUIConfig grayFontColorDeep];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).with.offset(15);
        make.top.equalTo(line.mas_top).with.offset(5);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@80);
        
    }];
    
    
    commentLabel.textColor = [GUIConfig grayFontColor];
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.numberOfLines=0;
    commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    commentLabel.text=@"1.解释权归商家所有\n2.用餐前先预约\n3.用餐高峰需要排队\n4.有效期为一年";
    
    
    
    
    
    
    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
