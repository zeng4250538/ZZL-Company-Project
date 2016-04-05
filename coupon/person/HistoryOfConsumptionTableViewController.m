//
//  HistoryOfConsumptionTableViewController.m
//  coupon
//
//  Created by ZZL on 16/3/23.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "HistoryOfConsumptionTableViewController.h"
#import "HistoryOfConsumptionTableViewCell.h"
#import "ChildPagesViewController.h"
#import "HistoryOfConsumptionService.h"
#import "AppShareData.h"
@interface HistoryOfConsumptionTableViewController ()

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation HistoryOfConsumptionTableViewController

- (void)viewDidLoad {
    [SVProgressHUD dismiss];
    [super viewDidLoad];
//    view=bigimgView.userInteractionEnabled=YES
    [self.view setUserInteractionEnabled:YES];
//    [self netWorkRequst];
    [SVProgressHUD show];
    [self.navigationItem setTitle:@"消费历史"];
    
//    [];
    
    [self.tableView registerClass:[HistoryOfConsumptionTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)netWorkRequst{
    AppShareData *app = [AppShareData instance];
 
    HistoryOfConsumptionService *HistoryOfConsumptionRequst = [HistoryOfConsumptionService new];
    [HistoryOfConsumptionRequst requestCustomerid:app.customId HistoryOfConsumptionSuccess:^(id data) {
        
//        NSLog(@"%@",data);
        self.dataArray = data;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSInteger code) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    [self netWorkRequst];
//    NSLog(@"%@",self.dataArray);
    return self.dataArray.count;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryOfConsumptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell lodeData:self.dataArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ChildPagesViewController *childPages = [ChildPagesViewController new];
    
    childPages.data = self.dataArray[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:childPages animated:YES];
    
    

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
