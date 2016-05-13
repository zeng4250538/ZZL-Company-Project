//
//  EditViewCtrl.m
//  coupon
//
//  Created by chijr on 16/5/10.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "EditViewCtrl.h"




@interface EditViewCtrl ()


@property(nonatomic,strong)UITextField *inputTextField;
@property(nonatomic,assign)BOOL isUpdated;


@end

@implementation EditViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isUpdated = NO;
    
    
    if (self.editFieldType == CustomerFieldTypeName) {
        
        
        self.navigationItem.title=@"修改姓名";
        
        
    }

    if (self.editFieldType == CustomerFieldTypeSex) {
        
        
        self.navigationItem.title=@"修改性别";
        
        
    }

    
    
    if (self.editFieldType == CustomerFieldTypeCity) {
        
        
        self.navigationItem.title=@"修改城市";
        
        
    }

    
    self.inputTextField = [UITextField new];
    
    [self.view addSubview:self.inputTextField];
    
    self.view.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@30);
        
    }];
    
    
    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.inputTextField.leftView =[[UIView alloc] init];
    
    self.inputTextField.leftView.backgroundColor = [UIColor whiteColor];
    
    self.inputTextField.leftView.frame = CGRectMake(0, 0, 10, 30);
    
    
    
    self.inputTextField.backgroundColor = [UIColor whiteColor];
    
    self.inputTextField.font = [UIFont systemFontOfSize:14];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        if ([self.inputTextField.text length]<1) {
            [SVProgressHUD showErrorWithStatus:@"数据不能为空"];
            return ;
        }
        
        
        CustomerService *service = [CustomerService new];
        
        [service updateCustomer:self.editFieldType value:self.inputTextField.text success:^(NSInteger code, NSString *message, id data) {
            
            
            self.isUpdated = YES;
            [SVProgressHUD showSuccessWithStatus:@"数据修改成功"];
            
            if (!self.isUpdated) {
                return;
            }
            
            
            if (self.updateBlock) {
                
                self.updateBlock(self.editFieldType, self.inputTextField.text);
            }

            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            
            [SVProgressHUD showErrorWithStatus:@"数据修改错误！"];
            
            
            
            
        }];
        
        
        
        
        
        
        
        
        
        
        
    }];
    
    
    self.inputTextField.text = self.value;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
 
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
