//
//  ShopCommentEditViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/23.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopCommentEditViewCtrl.h"
#import "ShopInfoTableViewCell.h"


@interface ShopCommentEditViewCtrl ()


@end

@implementation ShopCommentEditViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[ShopInfoTableViewCell class] forCellReuseIdentifier:@"shopCell"];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"商家评价";
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    uv.backgroundColor =[UIColor whiteColor];
    
    self.tableView.tableFooterView = uv;
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"发布" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        return [ShopInfoTableViewCell height];
        
    }
    
    return 50;
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    if (indexPath.section==0) {
        
        
        ShopInfoTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"shopCell" forIndexPath:indexPath];
        
        
        
        NSArray *list = [[MockData instance] randomShopModel:1];
        
        
        cell.data = list[0];
        
        [cell updateData];
        
        return cell;
        
        
        
    }
  
    if (indexPath.section==1) {
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
      
        
        //UILabel *nameLabel = [UILabel new];
        
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text=@"商家的印象";
        
        
        [cell.contentView addSubview:nameLabel];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).offset(20);
            make.width.equalTo(@80);
        }];
        
        
        UIButton *likeButton = [GUIConfig iconGood];
        
        
        [cell.contentView addSubview:likeButton];
        
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(nameLabel.mas_right).with.offset(20);
            make.centerY.equalTo(cell.contentView);
            
        }];
        
        //喜欢按钮
        
        [likeButton bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UILabel *likeLabel = [UILabel new];
        [cell.contentView addSubview:likeLabel];
        
        
        likeLabel.textColor=[GUIConfig grayFontColor];
        likeLabel.font = [UIFont systemFontOfSize:12];
        likeLabel.text=@"赞";
        [likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //make.width.equalTo(@40);
            make.left.equalTo(likeButton.mas_right).with.offset(10);
            make.centerY.equalTo(cell.contentView);
            
        }];
        
        
        
        UIButton *unlikeButton = [GUIConfig iconBad];
        
        
        
        
        [cell.contentView addSubview:unlikeButton];
        
        
        //不喜欢按钮
        [unlikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(likeLabel.mas_right).with.offset(20);
            make.centerY.equalTo(cell.contentView);
        }];
        
        
        [unlikeButton bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *unlikeLabel = [UILabel new];
        [cell.contentView addSubview:unlikeLabel];
        
        
        unlikeLabel.textColor=[GUIConfig grayFontColor];
        unlikeLabel.font = [UIFont systemFontOfSize:12];
        unlikeLabel.text=@"倒赞";
        [unlikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@40);
            make.left.equalTo(unlikeButton.mas_right).with.offset(10);
            make.centerY.equalTo(cell.contentView);
            
        }];
        
        
        
        
        
        
        
        return cell;
        
        
        
        
        
        
     //   return cell;
        
        
        
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    //UILabel *nameLabel = [UILabel new];
    
    return cell;
    

    
    // Configure the cell...
   
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
