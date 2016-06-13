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
#import "ClearCache.h"
@interface SettingViewCtrl ()

@end

@implementation SettingViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    self.navigationItem.title=@"设置";
    
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section==0) {
        return 3;
    }
    
    if (section==1) {
        return 2;
    }
    if (section==2) {
        return 1;
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
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
             cell.textLabel.text=@"霸气测试中";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0 && indexPath.section==0) {
        
        
        MessagePromptConfigViewCtrl *vc = [MessagePromptConfigViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if (indexPath.row==1 && indexPath.section==0) {
        
        ImageDisplayConfigViewCtrl *vc = [ImageDisplayConfigViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
 
    if (indexPath.row==2 && indexPath.section==0) {
        
        float i =  [ClearCache queryCache];
        
        NSString *string = [NSString stringWithFormat:@"有%.2f MB的缓存请确认是否清除",i];
        
        UIAlertView *av  = [UIAlertView bk_alertViewWithTitle:@"" message:string];
        
        [av bk_addButtonWithTitle:@"确定" handler:^{
            [ClearCache removedCache];
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
    
    if (indexPath.row == 0 && indexPath.section == 2) {
        
        UIActionSheet *as = [[UIActionSheet alloc] bk_initWithTitle:@""];

        
        [as bk_addButtonWithTitle:@"v1" handler:^{
            
            [[AppShareData instance] versionsSetNumber:@"v1"];
            
            
        }];
        
        
        [as bk_addButtonWithTitle:@"v1.0" handler:^{
            
            [[AppShareData instance] versionsSetNumber:@"v1.0"];
            
            
        }];
        
        [as bk_addButtonWithTitle:@"-------邪恶的分割线-------" handler:^{
            
            
            
            
        }];
        
        [as bk_addButtonWithTitle:@"外网" handler:^{
            
            
            InLan = NO;
            
            
        }];
        
        
        [as bk_addButtonWithTitle:@"内网" handler:^{
            
            
            InLan = YES;
            
        }];
        
        
        
        [as bk_addButtonWithTitle:@"-------邪恶的分割线-------" handler:^{
            
            
            
            
        }];
        
        
        [as bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];
        [as showInView:[UIApplication sharedApplication].keyWindow];
        
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
