//
//  EditViewCtrl.m
//  coupon
//
//  Created by chijr on 16/5/10.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "EditViewCtrl.h"
#import "CustomerService.h"

@interface EditViewCtrl ()


@property(nonatomic,strong)UITextField *inputTextField;


@end

@implementation EditViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.editFieldType == EditFieldTypeName) {
        
        
        self.navigationItem.title=@"修改姓名";
        
        
    }

    if (self.editFieldType == EditFieldTypeSex) {
        
        
        self.navigationItem.title=@"修改性别";
        
        
    }

    
    
    if (self.editFieldType == EditFieldTypeCity) {
        
        
        self.navigationItem.title=@"修改城市";
        
        
    }

    
    self.inputTextField = [UITextField new];
    
    [self.view addSubview:self.inputTextField];
    
    self.view.backgroundColor = [GUIConfig mainBackgroundColor];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(150);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
        
    }];
    
    
    
    self.inputTextField.backgroundColor = [UIColor whiteColor];
    
    self.inputTextField.font = [UIFont systemFontOfSize:14];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"发布" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        if ([self.inputTextField.text length]<1) {
            [SVProgressHUD showErrorWithStatus:@"数据不能为空"];
            return ;
        }
        
        
        CustomerService *service = [CustomerService new];
        
        [service updateCustomer:@"" fieldType:CustomerFieldTypeName value:self.inputTextField.text success:^(NSInteger code, NSString *message, id data) {
            
            
            
            [SVProgressHUD showSuccessWithStatus:@"数据修改成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            
            [SVProgressHUD showErrorWithStatus:@"数据修改错误！"];
            
            
            
            
        }];
        
        
        
        
        
        
        
        
        
        
        
    }];
    
    
    self.inputTextField.text = self.value;
    
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
