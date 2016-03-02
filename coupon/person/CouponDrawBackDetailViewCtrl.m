//
//  CouponDrawBackDetailViewCtrl.m
//  coupon
//
//  Created by chijr on 16/3/2.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponDrawBackDetailViewCtrl.h"
#import "CouponInfoTableViewCell.h"

@interface CouponDrawBackDetailViewCtrl ()

@end

@implementation CouponDrawBackDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title=@"退款详情";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
  
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"couponcell"];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0 && indexPath.section==0) {
        
        return [CouponInfoTableViewCell height];
        
    }else{
        
        
        return 60;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 0 ) {
        
        return 1;
    }
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row==0 && indexPath.section==0) {
        
        CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponcell" forIndexPath:indexPath];
        
        cell.data = self.data;
        
        [cell updateData];
        
        
        return cell;
        
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *uv in [cell.contentView subviews]) {
        
        [uv removeFromSuperview];
    }
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    titleLabel.textColor = [GUIConfig grayFontColorDeep];
    
    [cell.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(15);
        make.right.equalTo(cell.contentView);
        make.top.equalTo(cell.contentView).offset(5);
        make.height.equalTo(@20);
        
        
    }];
    
    titleLabel.text=@"申请";
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = [UIFont boldSystemFontOfSize:12];
    
    detailLabel.textColor = [UIColor lightGrayColor];
    
    [cell.contentView addSubview:detailLabel];
    
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(15);
        make.right.equalTo(cell.contentView);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.height.equalTo(@20);
        
        
    }];
    detailLabel.text=@"退货时间 2016-03-06";
    
   
    
    
     // Configure the cell...
    
    return cell;
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
