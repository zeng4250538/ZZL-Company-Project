//
//  ShopCommentViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/4.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ShopCommentViewCtrl.h"
#import "ShopCommentTableViewCell.h"
#import "ShopCommentSevice.h"
#import "BasketService.h"
#import "CommentService.h"
#import "QuickTableViewCell.h"
@interface ShopCommentViewCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *data;
@end

@implementation ShopCommentViewCtrl



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的评论";
    
    
    self.tableView = [GUIHelper makeTableView:self.view delegate:self];
    
    [self.tableView registerClass:[QuickTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    [self loadData];
    
    
    
    
}


-(void)loadData{
    
    
    [ReloadHud showHUDAddedTo:self.view reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.view animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.view];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.view animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.view];
        }
        
        
    }];
    
    
    
}
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    CommentService *service = [CommentService new];
    
    [service requestCommentWithShop:self.shopId page:1 per_page:10 sort:@""
    success:^(NSInteger code, NSString *message, id data) {
        
        
        self.data = data;
        
        [self.tableView reloadData];
        
        completion(YES);
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {

        completion(NO);

    }];


}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.translucent = NO;

    
    
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    QuickTableViewCell *cell =(QuickTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    NSDictionary *d = self.data[indexPath.row];
    
  
    
    cell.layoutBlock = ^(QuickTableViewCell *theCell){
        
        [theCell.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(theCell.contentView).offset(10);
            make.top.equalTo(theCell.contentView).offset(10);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
            
        }];
        
        theCell.iconImageView.layer.cornerRadius = 20;
        theCell.iconImageView.clipsToBounds = YES;
    
    
        [theCell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(theCell.iconImageView.mas_right).offset(10);
            make.top.equalTo(theCell.iconImageView);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
    
        theCell.titleLabel.font = [UIFont systemFontOfSize:15];
        theCell.titleLabel.textColor = [GUIConfig grayFontColorDeep];
    
        [theCell.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(theCell.iconImageView.mas_right).offset(10);
            make.top.equalTo(theCell.titleLabel.mas_bottom).offset(5);
            make.right.equalTo(theCell.contentView).offset(-10);
            make.bottom.equalTo(theCell.contentView).offset(-10);
        }];
        
        
        [theCell.dateTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(theCell.contentView.mas_right).offset(-10);
            make.top.equalTo(theCell.titleLabel);
            make.left.equalTo(theCell.titleLabel.mas_right).offset(5);
            make.height.equalTo(@20);
        }];
        
        theCell.dateTimeLabel.font = [UIFont systemFontOfSize:12];
        theCell.dateTimeLabel.textColor = [GUIConfig grayFontColorLight];
        theCell.dateTimeLabel.textAlignment = NSTextAlignmentRight;

    
        theCell.detailLabel.font = [UIFont systemFontOfSize:14];
        theCell.detailLabel.textColor = [GUIConfig grayFontColor];
        theCell.detailLabel.numberOfLines=0;
        theCell.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        
        
        
        
    };
    
     cell.updateBlock = ^(QuickTableViewCell *theCell){
         
         theCell.titleLabel.text =SafeString(d[@"customerName"]);
         theCell.detailLabel.text =SafeString(d[@"comment"]);
         theCell.dateTimeLabel.text =SafeLeft((NSString*)SafeString(d[@"time"]), 10);
         
         
        // [theCell sizeToFit];
         
         NSURL *url = SafeUrl(d[@"smallPhotoUrl"]);
         
         [theCell.iconImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
             
         }];
         
         
         
     };
    
    [cell updateData];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    return cell;
    
    
    
    
    
 }


#pragma mark - 长按删除

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    
    
    
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:self.tableView];
                         
        
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        
        
        if(indexPath == nil) return ;
        
        
        UIActionSheet *act = [UIActionSheet bk_actionSheetWithTitle:@"操作"];
        
        [act bk_addButtonWithTitle:@"删除" handler:^{
            
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            
            
            NSString *itemId = self.data[indexPath.row][@"id"];
            NSLog(@"-----------我的评论删除的ID%@",itemId);
            
            
            
            
            // [self.tableView reloadData];
            
            
            
            
            
            
            
            
        }];
        
        [act bk_setDestructiveButtonWithTitle:@"关闭" handler:^{
            
            
            
            
        }];
        
        
        [act showInView:self.view];
        
        //add your code here
        
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

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
