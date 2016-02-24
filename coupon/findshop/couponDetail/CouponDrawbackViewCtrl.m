//
//  CouponDrawbackViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/23.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CouponDrawbackViewCtrl.h"

@interface CouponDrawbackViewCtrl ()

@property(nonatomic,strong)NSArray *reasonList;

@end

@implementation CouponDrawbackViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"退款";
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.reasonList = @[
                        @"买多了/买错了",
                        @"计划有变，没时间消费",
                        @"去过，不太满意",
                        @"后悔了，不想买",
                        @"其他"
                        
                        
                        
                        
                        
                        
                        ];
    
    
    
    UIView *bgView = [UIView new];
    
    self.tableView.backgroundColor = [GUIConfig mainBackgroundColor];
    
    bgView.backgroundColor = [GUIConfig mainBackgroundColor];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    self.tableView.tableFooterView = bgView;
    
    
    UIButton *drawBackButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    drawBackButton.backgroundColor = [GUIConfig mainBackgroundColor];
    
    drawBackButton.backgroundColor = [GUIConfig mainColor];
    
    [drawBackButton setTitle:@"确认退款" forState:UIControlStateNormal];
    
    [drawBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [bgView addSubview:drawBackButton];
    
    [drawBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(bgView).offset(20);
        make.left.equalTo(bgView).offset(40);
        make.right.equalTo(bgView).offset(-40);
        make.height.equalTo(@40);
        
    }];
    
    
    
    
    
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
    if (section==0) {
        return 0;
    }
    
    return 30;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==1) {
        UIView *headerView = [UIView new];
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
        UILabel *nameLabel = [UILabel new];
        nameLabel.textColor = [GUIConfig grayFontColor];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.frame = CGRectMake(20, 0, SCREEN_WIDTH-20, 30);
        nameLabel.text=@"退款原因";
        headerView.backgroundColor = [GUIConfig mainBackgroundColor];
        [headerView addSubview:nameLabel];
        return headerView;
    }
    
    return nil;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    // Return the number of rows in the section.
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return [self.reasonList count];
    }
    
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [GUIConfig grayFontColorDeep];
        if (indexPath.row==0) {
            
            
            cell.textLabel.text=[NSString stringWithFormat:@"优惠券：%@",self.data[@"name"]];
            
            
        }
        
        if (indexPath.row==1) {
            
            cell.textLabel.text=[NSString stringWithFormat:@"退款金额：￥%@元",self.data[@"price"]];
            
            
            
        }
        
    
    }
    
    if (indexPath.section==1) {
        
        
        
        UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        checkButton.selected = NO;
        
        checkButton.tag=1;
        
        [cell.contentView addSubview:checkButton];
        
        [checkButton setImage:[UIImage imageNamed:@"CellNotSelected@2x.png"] forState:UIControlStateNormal];
        [checkButton setImage:[UIImage imageNamed:@"CellRedSelected@2x.png"] forState:UIControlStateSelected];
        
        
        
        [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.centerY.equalTo(cell.contentView);
        }];
        
        
        
        
        
        
        [checkButton bk_addEventHandler:^(id sender) {
            
            UIButton *btn = (UIButton*)sender;
            
            btn.selected = !btn.selected;
            
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *reasonLabel = [UILabel new];
        
        [cell.contentView addSubview:reasonLabel];
        
        reasonLabel.font = [UIFont systemFontOfSize:14];
        reasonLabel.textColor = [GUIConfig grayFontColorDeep];
        
        reasonLabel.text=self.reasonList[indexPath.row];
        
        [reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(50);
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).offset(20);
            
            
            
        }];
//
    }
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIButton *btn = (UIButton*)[cell.contentView viewWithTag:1];
    
    btn.selected = ! btn.selected;
    
    
    
    
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
