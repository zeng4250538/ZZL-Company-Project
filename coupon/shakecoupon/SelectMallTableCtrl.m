//
//  SelectMallTableCtrl.m
//  coupon
//
//  Created by chijr on 16/1/13.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "SelectMallTableCtrl.h"
#import "Shop.h"
#import "MallService.h"


@interface SelectMallTableCtrl ()<UISearchBarDelegate,UISearchDisplayDelegate>

@property(nonatomic,strong)NSArray *sectionList;
@property(nonatomic,strong)NSDictionary *mallList;
@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)NSArray *keyList;
@property(nonatomic,strong)NSDictionary *dataMap;

@property(nonatomic,strong)NSArray *filterData;







@end

@implementation SelectMallTableCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
     [self makeSearchBar];
    self.navigationItem.title=@"选择商城";
    
    
    [GUIConfig tableViewGUIFormat:self.tableView];
    
    
    self.navigationController.navigationBar.barTintColor = [GUIConfig mainColor];
    
    [self loadData];
    
    
    
    
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}





-(void)makeSearchBar{
    
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    //self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.searchBar.barTintColor = [GUIConfig mainBackgroundColor];
    
    self.searchBar.backgroundImage =[UIImage new];
    
    self.searchBar.delegate= self;
    
    //self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.backgroundColor = [UIColor whiteColor];
    
    self.searchBar.backgroundColor = [GUIConfig mainBackgroundColor];
    
    
    
    UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    [bgView addSubview:self.searchBar];
    
    
    
    self.tableView.tableHeaderView = bgView;
    
    
    
    
}

-(void)makePyData{
    
    
    NSMutableArray *pyArray = [NSMutableArray arrayWithCapacity:10];
    
    for (NSDictionary *d in self.data) {
        
        
        NSString *name = d[@"name"];
        
        NSString *py = [Utils firstLetAllWord:name];
        
        py = [py stringByAppendingString:name];
        
        NSMutableDictionary *md = [d mutableCopy];
        
        md[@"py"]=py;
        
        [pyArray addObject:md];
        
        
        
    }

    
    self.data = pyArray;
    
    
    
    
}

-(void)makeSortData{
    
    
    
    NSMutableDictionary *dict=[@{} mutableCopy];
    
    //将列表变成 字典 ，结构如下 @{"a":@[@{"cccc"},@{"bbbbbb"}]};
    for (NSDictionary *d in self.filterData) {
        NSString *name = d[@"name"];
        
        
        NSString *letter = [Utils firstLetter:name];
        
        NSMutableArray *ary = dict[letter];
        
        if (ary==nil) {
            ary = [@[] mutableCopy];
            dict[letter]=ary;
        }
        
        [ary addObject:d];
        
    }
    
    
    
    self.dataMap =dict;
    
    self.keyList = [self.dataMap allKeys];
    
    
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    self.keyList = [self.keyList sortedArrayUsingDescriptors:@[sd]];
    
    [self.tableView reloadData];
    
    
    
    
    
    
    
}


-(void)loadData{
    
    
    [ReloadHud showHUDAddedTo:self.tableView reloadBlock:^{
        
        
        [self doLoad:^(BOOL ret){
            
            if (ret) {
                [ReloadHud removeHud:self.tableView animated:YES];
            }else{
                
                [ReloadHud showReloadMode:self.tableView];
            }
            
            
        }];
        
        
    }];
    
    
    [self doLoad:^(BOOL ret){
        
        if (ret) {
            [ReloadHud removeHud:self.tableView animated:YES];
        }else{
            
            [ReloadHud showReloadMode:self.tableView];
        }
        
        
    }];
    
    
    
}
-(void)doLoad:(void(^)(BOOL ret))completion{
    
    MallService *service = [MallService new];
    
    
    [service queryMallByCity:[AppShareData instance].city success:^(NSInteger code, NSString *message, id data) {
        
        self.data = data;
        
        NSMutableArray *arrayData = [data mutableCopy];
        
        self.filterData = arrayData;
        NSLog(@"asdassssssss.......................>>>>>>>>>>>>%@",self.filterData);

        [self makeSortData];
        
        

        
        [self.tableView reloadData];
        
        completion(YES);
    } failure:^(NSInteger code, BOOL retry, NSString *message, id data) {
        
        
        completion(NO);
        
    }];
    
    
}




-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keyList;
}


-(void)doSearchFilter:(NSString*)searchString{
    
    
    //年龄小于30
    //定义谓词对象，谓词对象中包含了过滤条件
    
    
    [self makePyData];
    
    
    NSString *condition = [NSString stringWithFormat:@"py like[c] '*%@*'",searchString];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:condition];
    //使用谓词条件过滤数组中的元素，过滤之后返回查询的结果
    NSArray *array = [self.data filteredArrayUsingPredicate:predicate];
    
    
    self.filterData = array;
    
   // self.filterData = array;
    
   // [self makeMapData];
    
    [self makeSortData];
    
    [self.tableView reloadData];
    
    
    //查询name=1的并且age大于40
    
    
    
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    NSLog(@"xxxx");
    
    
    [self doSearchFilter:searchText];
    
   // -(void)doSearchFilter:(NSString*)searchString{


    

}

//-(void)loadData{
//    
//    
//    self.sectionList=@[@"位置",@"T",@"W"];
//    
//    self.mallList = @{@"位置":@[@"正佳广场"],
//                      @"T":@[@"天河城",@"太古汇"],
//                      @"W":@[@"万达广场",@"万象城"]
//                      };
//    
//    
//    
//    
//    
//    
//    
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    
    UILabel *lab = [UILabel new];
    
    lab.backgroundColor = [GUIConfig mainBackgroundColor];
    
    NSString *name = self.keyList[section];
    
    lab.text = [NSString stringWithFormat:@"  %@",name];
    
    lab.font  = [UIFont systemFontOfSize:14];
    lab.textColor = [GUIConfig grayFontColor];
    
    return lab;
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.keyList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSString *key = self.keyList[section];
    
    return [[self.dataMap objectForKey:key] count];
    
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSString *key = self.keyList[indexPath.section];
//    NSLog(@"asdassssssss.......................>>>>>>>>>>>>%@",key);
    NSArray *dataList = [self.dataMap objectForKey:key];
    
    NSDictionary * d= dataList[indexPath.row];
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [GUIConfig grayFontColorDeep];
    
    cell.textLabel.text =SafeString(d[@"name"]);
    
    //cell.textLabel.text=@"xxxxx"
    
    
   // currentCityList[[indexPath row]];
    
    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = self.keyList[indexPath.section];
    
    NSArray *dataList = [self.dataMap objectForKey:key];
    
    NSDictionary * d= dataList[indexPath.row];
    
    
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        if (self.selectMallBlock) {
            self.selectMallBlock(YES,d);
        }
        
    }];
    
  //  [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
