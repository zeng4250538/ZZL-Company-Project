//
//  CartViewCtrl.m
//  coupon
//
//  Created by chijr on 16/1/13.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "CartViewCtrl.h"

#import "CouponInfoTableViewCell.h"
#import "ToPayTableViewCtrl.h"
#import "AppShareData.h"


@interface CartViewCtrl ()

@end

@implementation CartViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, SCREEN_HEIGHT-45) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self.tableView registerClass:[CouponInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.title=@"篮子";
    
    [self makeMenuView];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)makeMenuView{
    
    
    
    
    NSArray *titleList = @[@"未付款",@"未消费",@"已消费"];
    
    CGFloat barHeight=45;
    CGFloat menuWidth = SCREEN_WIDTH/3;
    CGFloat menuHeight = barHeight-2;
    CGFloat lineWidth = menuWidth/2;
    
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_HEIGHT, barHeight)];
    
    barView.layer.borderColor = [[GUIConfig mainBackgroundColor] CGColor];
    barView.layer.borderWidth=1;
    
    
    barView.backgroundColor =[UIColor whiteColor];
    
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((menuWidth-lineWidth)/2, 43, lineWidth, 1)];
    lineView.backgroundColor = [GUIConfig mainColor];
    
    [barView addSubview:lineView];
    
    
    CGFloat x = 0;
    CGFloat pos=0;
    for (NSString *name in titleList) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = pos+1;
        
        
        [btn layout:^(UIView *view) {
            
            UIButton *btn = (UIButton*)view;
            btn.frame = CGRectMake(x, 0, menuWidth, menuHeight);
            [btn setTitle:name forState:UIControlStateNormal];
            [btn setTitleColor:[GUIConfig grayFontColor] forState:UIControlStateNormal];
            [btn setTitleColor:[GUIConfig mainColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            
            if (pos==0) {
                [btn setSelected:YES];
            }
            
            
            if (pos==0 || pos==1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(menuWidth,12 , 1, 44-24)];
                line.backgroundColor = [GUIConfig mainBackgroundColor];
                [btn addSubview:line];
                
            }
            
            [btn bk_addEventHandler:^(id sender) {
                
                UIButton *b = (UIButton*)sender;
                UIView *uv = b.superview;
                for (UIButton *btn in [uv subviews]) {
                    
                    
                    if ([btn isKindOfClass:[UIButton class]]) {
                        btn.selected=NO;
                        
                    }
                }
                
                btn.selected=YES;
                
                NSUInteger newPos = btn.tag-1;
                
                
                
                [UIView animateWithDuration:0.3f animations:^{
                    lineView.frame =CGRectMake(newPos*menuWidth+(menuWidth-lineWidth)/2, 43, lineWidth, 1);
                    
                }];
                
                
                [self.tableView reloadData];
                
                
                
                if (btn.tag==1) {
                    
                    
                    self.cartType =0;
                    
                    
                    [self.tableView reloadData];
                    
                    
                    
//                    [self tableLoadData];
                    
                    
                }
                
                if (btn.tag==2) {
                    
                    
                    self.cartType =1;
                    
                    
                    [self.tableView reloadData];
                    
                    
//                    [self tableLoadData];
                    
                    
                    
                    //                    [self loadData:^(NSInteger code) {
                    //
                    //                    }];
                }
                
                if (btn.tag==3) {
                    
                    self.cartType =2;
                    
                    
                    [self.tableView reloadData];
                    
                    
                    
//                    [self tableLoadData];
                    
                    
                    
                    //                    [self loadData:^(NSInteger code) {
                    //
                    //                    }];
                }
                
                
                
            } forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            [barView addSubview:btn];
            
        }];
        
        
        x = x+menuWidth;
        pos++;
        
    }
    
    [self.view addSubview:barView];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CouponInfoTableViewCell height];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    
    if (self.cartType==0) {
        return [AppShareData instance].getCartCount;
    }
    if (self.cartType==1) {
        return 3;
    }
    if (self.cartType==2) {
        return 6;
    }

    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    NSDictionary *d = [AppShareData instance].getCartList[ [indexPath row]];
    
    cell.payBlock = ^(NSDictionary *data){
        
        ToPayTableViewCtrl *vc = [ToPayTableViewCtrl new];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    };
    
    
    
    if (self.cartType ==0) {
        cell.couponType = CouponTypeToPay;
        
        [cell updateData:d];
        
        return cell;
        
    }else if (self.cartType ==1) {
        cell.couponType = CouponTypeToUse;
        
        
    }else{
        
        cell.couponType = CouponTypeNormal;

    }
    
   
    
    
    [cell updateData];

    
    
    
    
    
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
