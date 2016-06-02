//
//  RegisterViewCtrl.m
//  coupon
//
//  Created by chijr on 16/3/13.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "RegisterViewCtrl.h"
#import "LoginService.h"
@interface RegisterViewCtrl ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *mobileTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UITextField *repeatPasswordTextField;
@property(nonatomic,strong)UITextField *smsCodeTextField;
@property(nonatomic,strong)UIButton *smsButton;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)int i;
@end

@implementation RegisterViewCtrl

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title=@"用户注册";
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self makeFooterView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        
        [self.view endEditing:YES];
        
    }];
    
    [self.view addGestureRecognizer:tap];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


//------------------------

#define kAlphaNum  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kAlpha      @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
#define kNumbers     @"0123456789"
#define kNumbersPeriod  @"0123456789."

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (self.passwordTextField ||self.repeatPasswordTextField) {
        
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
        NSString *filtered =
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        return basic;
        
    }
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kNumbers] invertedSet];
    NSString *filtered =
    [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [string isEqualToString:filtered];
    return NO;

    
}

//----------------------------



//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==4) {
        
        return 2;
    }
    
    return 60;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    if (indexPath.row==0) {
        
        self.mobileTextField = [GUIHelper makeTableCellTextField:@"手机号：" cell:cell];
        self.mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.mobileTextField.delegate = self;
    }

    if (indexPath.row==1) {
        
        self.passwordTextField = [GUIHelper makeTableCellTextField:@"密码：" cell:cell];
        self.passwordTextField.secureTextEntry = YES;
        self.passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
        self.passwordTextField.delegate = self;
        self.passwordTextField.secureTextEntry = YES;
    }

    if (indexPath.row==2) {
        
        self.repeatPasswordTextField = [GUIHelper makeTableCellTextField:@"重复密码：" cell:cell];
        self.repeatPasswordTextField.secureTextEntry = YES;
        self.repeatPasswordTextField.keyboardType = UIKeyboardTypeAlphabet;
        self.repeatPasswordTextField.delegate = self;
        self.repeatPasswordTextField.secureTextEntry = YES;
    }
    

    
    if (indexPath.row==3) {
        
        self.smsCodeTextField = [GUIHelper makeTableCellTextField:@"短信验证码：" cell:cell];
        
        self.smsCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        _smsButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [cell.contentView addSubview:_smsButton];
        
        [_smsButton setTitle:@"验证码" forState:UIControlStateNormal];
        [_smsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _smsButton.backgroundColor = [GUIConfig mainColor];
        
        [_smsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).offset(-10);
            make.centerY.equalTo(cell.contentView);
            make.width.equalTo(@80);
            make.height.equalTo(@30);
            
            
        }];
        _smsButton.layer.cornerRadius = 2;
        self.i = 60;
        
        [_smsButton bk_addEventHandler:^(id sender) {
            
            [self verificationCodeLoadData];
            [_smsButton setUserInteractionEnabled:NO];
            _smsButton.backgroundColor = [UIColor grayColor];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerNumber) userInfo:nil repeats:YES];
            
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
    }
    
    
    // Configure the cell...
    
    return cell;
}

-(void)timerNumber{

    self.i --;
    
    [_smsButton setTitle:[NSString stringWithFormat:@"验证码 %d",self.i] forState:UIControlStateNormal];
    
    if (self.i==0) {
        [_smsButton setUserInteractionEnabled:YES];
        [_smsButton setTitle:@"验证码" forState:UIControlStateNormal];
        _smsButton.backgroundColor = [GUIConfig mainColor];
        [_timer invalidate];
        
    }

}



-(void)verificationCodeLoadData{

    LoginService *app = [LoginService new];
    [app verificationCode:_mobileTextField.text password:@"0" success:^(NSInteger code, NSString *message, id data) {
        
    } failure:^(id data) {
        
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
    
    loginButton.layer.cornerRadius = 2;
    
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.tableView.tableFooterView = footer;
    
    
    [loginButton bk_addEventHandler:^(id sender) {
        
        
        if ([self.mobileTextField.text length]<1) {
            
            [SVProgressHUD showErrorWithStatus:@"手机号为空"];
            
            return;
            
        }
        
        if ([self.mobileTextField.text length]!=11) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            
            return;

            
        }
        
        if ([self.passwordTextField.text length]<1) {
            
            [SVProgressHUD showErrorWithStatus:@"密码为空"];
            
            return ;
            
        }
        
        if ([self.repeatPasswordTextField.text length]<1) {
            
            [SVProgressHUD showErrorWithStatus:@"密码为空"];
            
            return ;
            
        }
        
        if ([self.smsCodeTextField.text length]<1) {
            
            [SVProgressHUD showErrorWithStatus:@"验证码为空"];
            
            return ;
            
        }
        
        if (![self.passwordTextField.text isEqualToString:self.repeatPasswordTextField.text]) {
            [SVProgressHUD showErrorWithStatus:@"重新输入的密码不正确"];
        }
        
        
        LoginService *log = [LoginService new];
        [log doRegister:_mobileTextField.text password:_repeatPasswordTextField.text verificationCode:_smsCodeTextField.text success:^(NSInteger code, NSString *message, id data) {
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [_smsButton setUserInteractionEnabled:YES];
            [_smsButton setTitle:@"验证码" forState:UIControlStateNormal];
            _smsButton.backgroundColor = [GUIConfig mainColor];
            [_timer invalidate];
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            [SVProgressHUD showInfoWithStatus:@"手机号已注册过了"];
            
        }];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
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
