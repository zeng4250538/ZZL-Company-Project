//
//  ToPayTableViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/13.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ToPayTableViewCtrl.h"

@interface ToPayTableViewCtrl ()

@end

@implementation ToPayTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"支付页面";
    
    
   // [GUIConfig tableViewGUIFormat:self.tableView];
    
    
   // [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    UIView *uv = [UIView new];
    uv.frame= CGRectMake(0, 0, SCREEN_WIDTH, 300);
    
    uv.backgroundColor = [GUIConfig mainBackgroundColor];

    self.tableView.tableFooterView = uv;
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn.frame= CGRectMake(30, 10, SCREEN_WIDTH-60, 40);
    
    [uv addSubview:btn];
    
    
    [btn setTitle:@"确认支付" forState:UIControlStateNormal];
    
    btn.backgroundColor = [GUIConfig mainColor];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    

    
    
        

    
    
    
    
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)viewDidAppear:(BOOL)animated{
//    
//    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
//    
//    
//}

#pragma mark - Table view data source


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return @"支付内容";
    }
    if (section ==1) {
        return @"支付方式";
    }
    
    return @"";
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section==0) {
        return 3;
    }
    if (section==1) {
        return 2;
    }
    
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *uv in [cell.contentView subviews]) {
        [uv removeFromSuperview];
    }
    
    
    if ([indexPath section]==0) {
        if ([indexPath row]==0) {
            
            
            
            UILabel *nameLabel = [UILabel new];
            
            [cell.contentView addSubview:nameLabel];
            
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(15);
                make.top.bottom.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-80);
                
            }];
            
            nameLabel.text=@"咖啡懂你代金券";
            nameLabel.font = [UIFont systemFontOfSize:14];
            
  
            UILabel *priceLabel = [UILabel new];
            
            [cell.contentView addSubview:priceLabel];
            
            
            [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(cell.contentView).offset(-20);
                make.width.mas_equalTo(40);
                make.top.bottom.equalTo(cell.contentView);
                
            }];
            
            priceLabel.text=@"￥14";
            priceLabel.font = [UIFont systemFontOfSize:14];
            
            
            
            
            
        }
  
        if ([indexPath row]==1) {
            
            UILabel *nameLabel = [UILabel new];
            
            [cell.contentView addSubview:nameLabel];
            
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(15);
                make.top.bottom.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-80);
                
            }];
            
            nameLabel.text=@"数量";
            nameLabel.font = [UIFont systemFontOfSize:14];
            
            
            UILabel *numLabel = [UILabel new];
            
            [cell.contentView addSubview:numLabel];
            
            
            [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(cell.contentView).offset(-20);
                make.width.mas_equalTo(40);
                make.top.bottom.equalTo(cell.contentView);
                
            }];
            
            numLabel.text=@"1";
            numLabel.font = [UIFont systemFontOfSize:14];
            
            
            
            
        }
  
        if ([indexPath row]==2) {
            
            
            UILabel *nameLabel = [UILabel new];
            
            [cell.contentView addSubview:nameLabel];
            
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.contentView).offset(15);
                make.top.bottom.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView).offset(-80);
                
            }];
            
            nameLabel.text=@"总价";
            nameLabel.font = [UIFont systemFontOfSize:14];
            
            
            UILabel *priceLabel = [UILabel new];
            
            [cell.contentView addSubview:priceLabel];
            
            
            [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(cell.contentView).offset(-20);
                make.width.mas_equalTo(40);
                make.top.bottom.equalTo(cell.contentView);
                
            }];
            
            priceLabel.text=@"￥14";
            priceLabel.font = [UIFont systemFontOfSize:14];
            
            
            
            
            
            
        }
        
    }
    
        if ([indexPath section]==1) {
            
            
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            if ([indexPath row]==0) {
                
                cell.textLabel.text = @"支付宝";
                
                
            }
            if ([indexPath row]==1) {
                
                cell.textLabel.text = @"微信";
                
                
            }


        
    }
    
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
