//
//  PersonDetailInfoViewCtrl.m
//  coupon
//
//  Created by chijr on 16/5/10.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "PersonDetailInfoViewCtrl.h"
#import "CustomerService.h"
#import "QuickTableViewCell.h"
#import "EditViewCtrl.h"
#import "ImageUploadService.h"

@interface PersonDetailInfoViewCtrl ()

@property(nonatomic,strong)NSMutableDictionary *data;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation PersonDetailInfoViewCtrl

-(void)viewWillAppear:(BOOL)animated{

    [self loadData];
    [self.tableView reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[QuickTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
//    [self loadData];
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    
    self.navigationItem.title=@"用户信息";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadData{
    
    
    [ReloadHud showHUDAddedTo:self.navigationController.view reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.navigationController.view animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.navigationController.view];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.navigationController.view animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.navigationController.view];
        }
        
        
    }];
    
    
    
}
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    
    
    CustomerService *service = [CustomerService new];
    
    
    
    NSString *customerId = [AppShareData instance].customId;
    
    
    [service requestCustomer:customerId success:^(NSInteger code, NSString *message, id data) {
        
               NSLog(@"data = %@ ",data);
        
//        self.useNameLabel.text = SafeString(data[@"nickname"]);
//        self.cityNameLabel.text = SafeString(data[@"cityName"]);
//        self.sexNameLabel.text = SafeString(data[@"gender"]);
//        
//        self.phoneNumberLabel.text = SafeString(data[@"phoneMsisdn"]);
//        
//        
//        NSURL *url = SafeUrl(data[@"smallPhotoUrl"]);
//        
//        
//        [self.headportraitView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//            
//        }];
//        
//
        
        
        self.data = [data mutableCopy];
        
        [self.tableView reloadData];
        
        
        completion(YES);
        
        
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        completion(NO);
        
        
    }];
    
    
    
    
    
    
    
    
    
    
}






#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 60;
    }
    
    return 40;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
  
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    cell.layoutBlock = ^(QuickTableViewCell *theCell){
        
        [theCell.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(theCell.contentView).offset(15);
            make.centerY.equalTo(theCell.contentView);
            make.width.equalTo(@150);
            make.height.equalTo(@20);
            
            
        }];
        
        theCell.titleLabel.font = [UIFont systemFontOfSize:14];
        
        theCell.titleLabel.textColor = [GUIConfig grayFontColorDeep];
        
        

        [theCell.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(theCell.contentView).offset(-15);
            make.centerY.equalTo(theCell.contentView);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            
            
            
            
            
        }];
        
        
        theCell.detailLabel.font = [UIFont systemFontOfSize:14];
        
        theCell.detailLabel.textColor = [GUIConfig grayFontColor];
        
        theCell.detailLabel.textAlignment = NSTextAlignmentRight;
        
        
        
        
        

        
        
        
    };
    
    
    cell.updateBlock = ^(QuickTableViewCell *theCell){
        
        
        if (indexPath.row==0) {
            
            
            theCell.titleLabel.text=@"头像";
            
            
            NSURL *url = SafeUrl(self.data[@"photoUrl"]);
            
            
            
            
            
            [theCell.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@50);
                make.centerY.equalTo(theCell.contentView);
                make.height.equalTo(@50);
                make.right.equalTo(theCell.contentView).offset(-10);
                
                }];
            
            
            
          //  [theCell.iconImageView sd_setImageWithURL:nil placeholderImage:nil options:SDWebImageCacheMemoryOnly];
            
            [theCell.iconImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly];
            self.imageView = theCell.iconImageView;
            
            
            
        
            
        }
        
        
        if (indexPath.row==1) {
            
            
            theCell.titleLabel.text=@"名字";
            
            theCell.detailLabel.text = SafeString(self.data[@"nickname"]);
            
        }
 
        
        if (indexPath.row==2) {
            
            
            theCell.titleLabel.text=@"城市";
            
            
            theCell.detailLabel.text = SafeString(self.data[@"cityName"]);

            
        }

        
        if (indexPath.row==3) {
            
            
            theCell.titleLabel.text=@"性别";
            
            
            theCell.detailLabel.text = SafeString(self.data[@"gender"]);

            
        }
        
        if ((indexPath.row==4)) {
            theCell.titleLabel.text=@"手机号码";
            
            
            theCell.detailLabel.text = SafeString(self.data[@"phoneMsisdn"]);
        }

        
        
    };
    
    
    [cell updateData];
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row==0) {
   
        UIActionSheet *act = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
        
        [act bk_addButtonWithTitle:@"拍照" handler:^{
            
            
            [self takePhoto];
            
            //            [self computeTotalPrice];
            
            
            // [self.tableView reloadData];
            
        }];
 
        [act bk_addButtonWithTitle:@"上传照片" handler:^{
            
            
            [self LocalPhoto];
            
            
            
            // [self.tableView reloadData];
            
        }];
        
        [act bk_setDestructiveButtonWithTitle:@"取消" handler:^{
            
        }];

        
        [act showInView:self.view];
        
        return ;
        
        
    }
    
    
    EditViewCtrl *vc = [EditViewCtrl new];
    
    if (indexPath.row==1) {
        vc.editFieldType = CustomerFieldTypeName;
        vc.value =SafeString(self.data[@"nickname"]);
    }
 
    if (indexPath.row==2) {
        vc.editFieldType = CustomerFieldTypeCity;
        
        vc.value =SafeString(self.data[@"cityName"]);

    }

    
    if (indexPath.row==3) {
        vc.editFieldType = CustomerFieldTypeSex;
        
        vc.value =SafeString(self.data[@"gender"]);
        
    }
    
    if (indexPath.row==4) {
        
        vc.editFieldType = CustomerFieldTypePhone;
        
        vc.value = SafeString(self.data[@"phoneMsisdn"]);
        
    }
    
    
    vc.updateBlock = ^(CustomerFieldType fieldType ,NSString *value){
        
        
        if (fieldType == CustomerFieldTypeName) {
            
            self.data[@"nickname"]=value;
        }
        if (fieldType == CustomerFieldTypeSex) {
            
            self.data[@"gender"]=value;
        }
      
        if (fieldType == CustomerFieldTypeCity) {
            
            self.data[@"cityName"]=value;
        }
        if (fieldType == CustomerFieldTypePhone) {
            self.data[@"phoneMsisdn"] = value;
        }
        
        
        [self.tableView reloadData];
        
        
        
        
        
    };
    

    
    
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    
    
    
    
     UIImage *image = info[UIImagePickerControllerEditedImage];
    
    
    CustomerService *cv = [CustomerService new];
    
    
    
    
    ImageUploadService *service = [ImageUploadService new];
    
    
    [service uploadImage:image success:^(NSInteger code, id object) {
        
         
        NSString *fileName = object[@"responseCode"];
        
        
        
        [cv updateCustomer:CustomerFieldTypePhoto value:fileName success:^(NSInteger code, NSString *message, id data) {
            
            
             
            
            [SVProgressHUD showSuccessWithStatus:@"头像上传成功"];
            
            self.imageView.image = image;
            
            self.inforMationRefreshBlock(@"");
            
            [picker dismissViewControllerAnimated:YES completion:^{
                //[self.tableView reloadData];

            }];
            
            
              
       
            
            
        } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
            
            
            [SVProgressHUD showErrorWithStatus:@"修改用户头像错误"];
            
            
        }];
        
        

        
        
        
        
        
        
    } failure:^(NSInteger code, NSString *content) {
        
        
        [SVProgressHUD showErrorWithStatus:@"文件上传错误"];
        
    }];
    
    
    
    
    
    
      
    
     //
    //
    
    
    //  [self presentViewController:vc animated:YES completion:nil];
    
}



-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}



//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    NSLog(@"图片选中");
//    //截取图片
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes =
//    [NSSet setWithObjects:@"text/html",@"text/plain", nil,nil];
//    // 参数
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    parameter[@"token"] = @"param....";
//    // 访问路径
//    NSString *stringURL = @"xxx";
//    
//    
//    [manager POST:stringURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        // 上传文件
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//        
//        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"上传成功");
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"上传错误");
//    }];
//}
//


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
