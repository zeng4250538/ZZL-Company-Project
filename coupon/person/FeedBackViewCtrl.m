//
//  FeedBackViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/21.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "FeedBackViewCtrl.h"
#import "FeedbackSevice.h"

@interface FeedBackViewCtrl ()

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UITextField *contactTextField;



@end

@implementation FeedBackViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"发布" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        FeedbackSevice *app = [FeedbackSevice new];
        
        [app feedbackString:_textView.text withSuccess:^(id data) {
            
            [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } withFailure:^(id data) {
            
           [SVProgressHUD showInfoWithStatus:@"反馈失败"];
            
        }];
        
    }];
    
    self.view.backgroundColor = [GUIConfig mainBackgroundColor];
    
    self.navigationItem.title=@"意见反馈";
    
    
    UITextView *textView = [UITextView new];
    
    self.textView = textView;
    
    self.textView.text=@"请输入反馈意见！";
    
    [self.view addSubview:textView];
    
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(64+20);
        make.height.equalTo(@100);
        
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    textView.backgroundColor =[UIColor whiteColor];
    
    
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    textView.scrollEnabled = YES;//是否可以拖动
    
    textView.delegate = self;
    
    
    
    
    
    
    //textView.t
    
    
    // Do any additional setup after loading the view.
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入反馈意见！"]) {
        
        textView.text = @"";
        
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请输入反馈意见！";
        
    }
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
