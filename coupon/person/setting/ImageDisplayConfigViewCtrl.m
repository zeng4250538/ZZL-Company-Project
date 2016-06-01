//
//  ImageDisplayConfigViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/27.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "ImageDisplayConfigViewCtrl.h"

@interface ImageDisplayConfigViewCtrl ()

@end

@implementation ImageDisplayConfigViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [GUIConfig tableViewGUIFormat:self.tableView backgroundColor:[GUIConfig mainBackgroundColor]];
    
    self.navigationItem.title=@"图片显示控制";
    
    
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
 
    
    
    
    
    
    
    
    if (indexPath.row==0) {
        
        cell.textLabel.text=@"2G/3G/4G 图片显示开关";
    }
    
  
    if (indexPath.row==1) {
        
        cell.textLabel.text=@"WIFI 图片显示开关";
    }
    
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10,80 , 20)];
    [cell.contentView addSubview:sw];
    
    sw.tag=indexPath.row+1;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    
    
    if (indexPath.row==0) {
        sw.on = ![AppShareData instance].notDisplayImageViaCell;
    }
    
    
    [sw bk_addEventHandler:^(id sender) {
        
        if (sw.tag==1) {
            
            if (sw.on) {
                
               // [[AppShareData instance] setNotDisplayImageViaCell:NO];
                
                
                
                
                
                
            }else{
                
                
             //   [[AppShareData instance] setNotDisplayImageViaCell:YES];
                
                
                
            }
            
        }
        
    } forControlEvents:UIControlEventValueChanged];
    
    
    
    // Configure the cell...
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath  animated:YES];
    
    
    
    
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
