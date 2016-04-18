//
//  CommentSubmitViewCtrl.m
//  coupon
//
//  Created by chijr on 16/4/17.
//  Copyright © 2016年 chijr. All rights reserved.
//

#import "CommentSubmitViewCtrl.h"
#import "CommentService.h"

@interface CommentSubmitViewCtrl ()

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *likeButton;
@property(nonatomic,strong)UIButton *notLikeButton;


@end

@implementation CommentSubmitViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"发表" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        
        [self doPublish];
        
        
        
    }];
    
    self.navigationItem.title=@"商家评论";
    
    
    [self makeTap];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void)doPublish{
    
    
    NSString *commentString = self.textView.text;
    
    if ([commentString length]<1) {
        [SVProgressHUD showErrorWithStatus:@"评论为空"];
        return;
    }
    
    
    
    
    CommentService *service = [CommentService new];
    
    
    
    NSString *shopId = SafeString(self.data[@"shopId"]);
    
    
    
    [service  postReview:shopId comment:commentString isLike:1 success:^(NSInteger code, NSString *message, id data) {
        
        [SVProgressHUD showSuccessWithStatus:@"评论更新成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        
        [SVProgressHUD showErrorWithStatus:@"评论更新错误！"];
        
        
    }];
    
    
    
    
    
    
}


-(void)makeTap{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        
        [self.tableView endEditing:YES];
    }];
    
    
    [self.tableView addGestureRecognizer:tap];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 80;
    }

    if (indexPath.section==1) {
        return 40;
    }

    if (indexPath.section==2) {
        return 100;
    }
    
    return 0;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    for (UIView *uv in [cell.contentView subviews]) {
        [uv removeFromSuperview];
    }
    
    
    if (indexPath.row==0 && indexPath.section==0) {
        
        UIImageView *logoView = [UIImageView new];
        
        [cell.contentView addSubview:logoView];
        
        [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(15);
            make.top.equalTo(cell.contentView).offset(10);
            make.bottom.equalTo(cell.contentView).offset(-10);
            make.width.equalTo(@100);
        }];
        
        NSURL *url = SafeUrl(self.data[@"couponPhotoUrl"]);
        [logoView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [cell setNeedsLayout];
            
        }];
        
        UILabel *shopLabel = [UILabel new];
        [cell.contentView addSubview:shopLabel];
        
        [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(logoView.mas_right).offset(10);
            make.top.equalTo(logoView.mas_top);
            make.right.equalTo(cell.contentView).offset(20);
            make.height.equalTo(@20);
            
        }];
        
        shopLabel.text = SafeString(self.data[@"shopName"]);
        shopLabel.font = [UIFont systemFontOfSize:14];
        shopLabel.textColor = [GUIConfig grayFontColor];
        
        UILabel *couponLabel = [UILabel new];
        [cell.contentView addSubview:couponLabel];
        
        [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(logoView.mas_right).offset(10);
            make.top.equalTo(shopLabel.mas_bottom).offset(5);
            make.right.equalTo(cell.contentView).offset(20);
            make.height.equalTo(@20);
            
        }];
        
        couponLabel.text = SafeString(self.data[@"couponName"]);
        
        couponLabel.font = [UIFont systemFontOfSize:12];
        couponLabel.textColor = [GUIConfig grayFontColorLight];
        
        return cell;

        
        
        
    }
    
    
    if (indexPath.row==0 && indexPath.section==1) {
        
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.text =@"对商家的印象";
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = [GUIConfig grayFontColor];
        
        [cell.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(15);
            make.centerY.equalTo(cell.contentView);
            make.height.equalTo(@20);
            make.width.equalTo(@120);
            
        }];
        
        
        UIButton *goodButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        UIButton *badButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        
        [goodButton setTintColor:[UIColor grayColor]];
        [cell.contentView addSubview:goodButton];
        
        [goodButton setImage:[UIImage imageNamed:@"good_icon"] forState:UIControlStateNormal];
        [goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(10);
            make.centerY.equalTo(cell.contentView);
            make.height.equalTo(@30);
            make.width.equalTo(@50);
        }];
        
        self.likeButton = goodButton;
        self.notLikeButton = badButton;
        
        
        UILabel *goodLabel = [UILabel new];
        goodLabel.text =@"赞";
        goodLabel.font = [UIFont systemFontOfSize:14];
        goodLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [cell.contentView addSubview:goodLabel];
        [goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodButton.mas_right).offset(-10);
            make.centerY.equalTo(cell.contentView);
            make.height.equalTo(@20);
            make.width.equalTo(@120);
            
        }];
        
        
        [goodButton bk_addEventHandler:^(id sender) {
            
            if (!goodButton.isSelected) {
                
                [goodButton setTintColor:[GUIConfig mainColor]];
                [badButton setTintColor:[UIColor grayColor]];
                
                [badButton setSelected:NO];
                
                [goodButton setSelected:YES];
                
               // [goodButton setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];

                
                [goodButton setHighlighted:NO];
                goodButton.backgroundColor = [UIColor clearColor];
                
            }else{
                
                
                [goodButton setSelected:NO];
                
                
                [goodButton setTintColor:[UIColor grayColor]];
                
                
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        

        
        
        
        

        
        [badButton setTintColor:[UIColor grayColor]];
        [cell.contentView addSubview:badButton];
        
        [badButton setImage:[UIImage imageNamed:@"bad_icon"] forState:UIControlStateNormal];
        [badButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodButton.mas_right).offset(20);
            make.centerY.equalTo(cell.contentView);
            make.height.equalTo(@30);
            make.width.equalTo(@50);
        }];
        
        
        [badButton bk_addEventHandler:^(id sender) {
            
            if (!badButton.isSelected) {
                
                [badButton setTintColor:[GUIConfig mainColor]];
                [goodButton setTintColor:[UIColor grayColor]];
                
                [goodButton setSelected:NO];
                
                
                [badButton setSelected:YES];
                
            }else{
                
                
                [badButton setSelected:NO];
                
                
                [badButton setTintColor:[UIColor grayColor]];
                
                
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *badLabel = [UILabel new];
        badLabel.text =@"倒赞";
        badLabel.font = [UIFont systemFontOfSize:14];
        badLabel.textColor = [GUIConfig grayFontColorDeep];
        
        [cell.contentView addSubview:badLabel];
        [badLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(badButton.mas_right).offset(-10);
            make.centerY.equalTo(cell.contentView);
            make.height.equalTo(@20);
            make.width.equalTo(@120);
            
        }];
        
     
    
    
    }
    
    if (indexPath.row==0 && indexPath.section==2) {
        
        UITextView *textView = [UITextView new];
        
        
        self.textView = textView;
        
        textView.text=@"对商家的服务还满意吗？给小伙伴分享一下吧！";
        textView.font = [UIFont systemFontOfSize:14];
        textView.textColor = [GUIConfig grayFontColorLight];
        textView.delegate =self;
        
        
        [cell.contentView addSubview:textView];
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView).offset(10);
            make.right.equalTo(cell.contentView).offset(-10);
            make.top.equalTo(cell.contentView).offset(10);
            make.bottom.equalTo(cell.contentView).offset(-10);
            
        }];
        
        
        
        
        
    }
    

    // Configure the cell...
    
    return cell;
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"对商家的服务还满意吗？给小伙伴分享一下吧！"]) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"对商家的服务还满意吗？给小伙伴分享一下吧！";
    }
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
