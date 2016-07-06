//
//  ChangePasswordViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/28.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ChangePasswordViewCtrl.h"
#import "LoginService.h"
@interface ChangePasswordViewCtrl ()
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *newsPasswordTextField;
@property(nonatomic,strong)UITextField *repeatPasswordTextField;


@property(nonatomic,strong)UIButton *btn;
@end

@implementation ChangePasswordViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"修改密码";
    
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    footerView.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btn setTitle:@"修改密码" forState:UIControlStateNormal];
    
    [footerView addSubview:_btn];
    
    
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _btn.backgroundColor = [GUIConfig mainColor];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView).offset(20);
        make.left.equalTo(footerView).offset(30);
        make.right.equalTo(footerView).offset(-30);
        make.height.equalTo(@40);
        
    }];
    LoginService *ls = [LoginService new];
    
    [_btn bk_addEventHandler:^(id sender) {
        
        if (self.nameTextField.text.length<6) {
            [SVProgressHUD showInfoWithStatus:@"原密码有误"];
            return ;
        }
        
        if (self.newsPasswordTextField.text.length<6) {
            [SVProgressHUD showInfoWithStatus:@"请输入至少6位的字母或数字的密码组合"];
            return;
        }
        
        if (self.repeatPasswordTextField.text.length<6) {
            [SVProgressHUD showInfoWithStatus:@"请输入至少6位的字母或数字的密码组合"];
            return;
        }
        
        if (self.repeatPasswordTextField.text != self.newsPasswordTextField.text) {
            [SVProgressHUD showInfoWithStatus:@"两次输入的新密码不一致"];
            return;
        }
        
       [ls modifyPassword:self.nameTextField.text withNewPassword:self.newsPasswordTextField.text withRepeatPassword:self.repeatPasswordTextField.text success:^(id data) {
           [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
           [self.navigationController popToRootViewControllerAnimated:YES];
       } failure:^(id data) {
           [SVProgressHUD showInfoWithStatus:@"修改密码失败"];

       }];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
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
        
        _nameTextField  = [GUIHelper makeTableCellTextField:@"原密码:" cell:cell];
        
        
        
    }
    
    if (indexPath.row==1) {
        
        _newsPasswordTextField = [GUIHelper makeTableCellTextField:@"新密码:" cell:cell];
        _newsPasswordTextField.secureTextEntry = YES;
        
        
    }
    
    if (indexPath.row==2) {
        
        _repeatPasswordTextField = [GUIHelper makeTableCellTextField:@"确认密码:" cell:cell];
        _repeatPasswordTextField.secureTextEntry = YES;
        
        
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
