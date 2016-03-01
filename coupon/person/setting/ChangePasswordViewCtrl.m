//
//  ChangePasswordViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/28.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ChangePasswordViewCtrl.h"

@interface ChangePasswordViewCtrl ()

@end

@implementation ChangePasswordViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"修改密码";
    
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    footerView.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"修改密码" forState:UIControlStateNormal];
    
    [footerView addSubview:btn];
    
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.backgroundColor = [GUIConfig mainColor];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView).offset(20);
        make.left.equalTo(footerView).offset(30);
        make.right.equalTo(footerView).offset(-30);
        make.height.equalTo(@40);
        
    }];
    
    self.tableView.tableFooterView = footerView;
    
    self.tableView.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    
    
    
    
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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    
    if (indexPath.row==0) {
        
        UITextField *nameTextField  = [GUIHelper makeTableCellTextField:@"用户名:" cell:cell];
        
        
        
    }
    
    if (indexPath.row==1) {
        
        UITextField *passwordTextField = [GUIHelper makeTableCellTextField:@"老密码:" cell:cell];
        passwordTextField.secureTextEntry = YES;
        
        
    }
    
    if (indexPath.row==2) {
        
        UITextField *passwordTextField = [GUIHelper makeTableCellTextField:@"新密码:" cell:cell];
        passwordTextField.secureTextEntry = YES;
        
        
    }
    
    
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
