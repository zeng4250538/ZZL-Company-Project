//
//  SettingMessageConfigViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/27.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "MessagePromptConfigViewCtrl.h"

@interface MessagePromptConfigViewCtrl ()

@property(nonatomic,strong)NSMutableArray *selectedArray;

//@property(nonatomic,assign)NSInteger selected;
@end

@implementation MessagePromptConfigViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
//    self.selectedArray =[@[@0,@0] mutableCopy];
    
    self.navigationItem.title=@"消息提醒设置";
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
//    _selected = 0;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    if (indexPath.row==0) {
        cell.textLabel.text = @"优惠券消息";
    }
    
    
    if ( [AppShareData instance].selected == 0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        //UITableViewCellAccessoryCheckmark
        //UITableViewCellAccessoryNone
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    
    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    NSInteger selected = [self.selectedArray[indexPath.row] integerValue];
    
    if ([AppShareData instance].selected == 0) {
        
        [AppShareData instance].selected = 1;
        [[AppShareData instance] setUMPush:@"NO"];

    }else{
        
        [AppShareData instance].selected = 0;
        [[AppShareData instance] setUMPush:@"YES"];
        
    }
    
//    self.selectedArray[indexPath.row] = @(selected);
    
    
    [self.tableView reloadData];
    
    

   // [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
    
    
    
    
    
    
    
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
