//
//  LoginViewCtrl.m
//  coupon
//
//  Created by chijr on 16/3/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "LoginViewCtrl.h"
#import "LoginService.h"
#import "RegisterViewCtrl.h"
#import "ForgetViewCtrl.h"

@interface LoginViewCtrl ()

@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;


@end

@implementation LoginViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"登录";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        
        [self.view endEditing:YES];
        
    }];
    
    [self.view addGestureRecognizer:tap];
  
    [self makeHeaderView];
    
    [self makeFooterView];
    
    
    
  //
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.navigationItem hidesBackButton];
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.hidesBackButton = YES;
    
    
    
}




-(void)makeHeaderView{
    
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    
    self.tableView.tableHeaderView = header;
    
    header.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    logoView.image = [UIImage imageNamed:@"logo"];
    
    [header addSubview:logoView];
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(header);
        make.height.width.equalTo(@80);
        
    }];
    
}


-(void)makeFooterView{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    footer.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [footer addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(footer).offset(30);
        make.right.equalTo(footer).offset(-30);
        make.top.equalTo(footer).offset(20);
        make.height.equalTo(@40);
        
        
    }];
    
    loginButton.backgroundColor = [GUIConfig mainColor];
    
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.tableView.tableFooterView = footer;
    
    
    [loginButton bk_addEventHandler:^(id sender) {
        
        
        if ([self.userNameTextField.text length]<1) {
            
            [SVProgressHUD showErrorWithStatus:@"用户名为空"];
            
//            return;
            
        }
        
   
        if ([self.passwordTextField.text length]<1) {
            
            [SVProgressHUD showErrorWithStatus:@"密码为空"];
            
//            return ;
            
        }
        
        NSString *userName = self.userNameTextField.text;
        NSString *password = self.passwordTextField.text;
        
        
        LoginService * service = [LoginService new];
        
        [SVProgressHUD showWithStatus:@""];
        
        [service doLogin:userName password:password success:^(NSInteger code, NSString *message, id data) {
            
            if (![data isKindOfClass:[NSDictionary class]]) {
                
                [SVProgressHUD showErrorWithStatus:@"数据格式错误！"];
//                return;
                
            }
            
            [SVProgressHUD dismiss];
            
            NSDictionary *returnData = data;
            
            NSString *accessToken = returnData[@"access_token"];
            
            [[AppShareData instance] saveLogin:userName password:password accessToken:accessToken];
            
            if (self.loginEndBlock) {
                
                self.loginEndBlock(YES);
            }
          
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            [SVProgressHUD showErrorWithStatus:@"登录出错"];
            
        }];
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [footer addSubview:registerButton];
    
   // registerButton.frame = CGRectMake(0, 0, 80, 30);
   // registerButton.layer.borderWidth=1;
    
    [registerButton setTitle:@"注册新用户" forState:UIControlStateNormal];
    
    [registerButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(loginButton);
        make.top.equalTo(loginButton.mas_bottom).offset(30);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    
    [registerButton bk_addEventHandler:^(id sender) {
        
        RegisterViewCtrl *vc = [RegisterViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    
    } forControlEvents:UIControlEventTouchUpInside];
    
    
  
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [footer addSubview:forgetButton];
    
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    [forgetButton setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
    
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(loginButton);
        make.top.equalTo(loginButton.mas_bottom).offset(30);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    [forgetButton bk_addEventHandler:^(id sender) {
        
        ForgetViewCtrl *vc = [ForgetViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==2) {
        return 2;
    }
    
    return 60;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    
 //   cell.textLabel.text=@"xxxxx";
    
    if (indexPath.row==0) {
        
      self.userNameTextField =   [GUIHelper makeTableCellTextField:@"用户名" cell:cell];

    }
    
    if (indexPath.row==1) {
       self.passwordTextField =  [GUIHelper makeTableCellTextField:@"密码" cell:cell];
        
        self.passwordTextField.secureTextEntry = YES;

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
