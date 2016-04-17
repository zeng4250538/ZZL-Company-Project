//
//  SettingViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/27.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "SettingViewCtrl.h"
#import "MessagePromptConfigViewCtrl.h"
#import "ImageDisplayConfigViewCtrl.h"
#import "ChangePasswordViewCtrl.h"
#import "SettingViewCtrl.h"
#import "AboutViewCtrl.h"

@interface SettingViewCtrl ()

@end

@implementation SettingViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"设置消息";
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    
   
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            cell.textLabel.text=@"消息提醒";
            
        }
        
        if (indexPath.row==1) {
            cell.textLabel.text=@"图片设置";
            
        }
        
        if (indexPath.row==2) {
            cell.textLabel.text=@"清除缓存";
            
        }
        
    }
    
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            cell.textLabel.text=@"修改密码";
            
        }
        
     
        if (indexPath.row==1) {
            cell.textLabel.text=@"关于";
            
        }
        
 
        
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    
    
    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0 && indexPath.section==0) {
        
        
        MessagePromptConfigViewCtrl *vc = [MessagePromptConfigViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if (indexPath.row==1 && indexPath.section==0) {
        
        ImageDisplayConfigViewCtrl *vc = [ImageDisplayConfigViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
 
    if (indexPath.row==2 && indexPath.section==0) {
        
        
        UIAlertView *av  = [UIAlertView bk_alertViewWithTitle:@"" message:@"请确认是否清除缓存信息"];
        
        [av bk_addButtonWithTitle:@"确定" handler:^{
            
        }];
        
        [av bk_addButtonWithTitle:@"取消" handler:^{
            
            
        }];
        
        [av show];
        
        
    }

    
    if (indexPath.row==0 && indexPath.section==1) {
        
        ChangePasswordViewCtrl *vc =[ChangePasswordViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row==1 && indexPath.section==1) {
        
        AboutViewCtrl *vc =[AboutViewCtrl new];
        
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
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
