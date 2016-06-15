//
//  AboutViewCtrl.m
//  coupon
//
//  Created by chijr on 16/2/28.
//  Copyright (c) 2016年 chijr. All rights reserved.
//

#import "AboutViewCtrl.h"
#import "VersionNumberSevice.h"
@interface AboutViewCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UILabel *versionLable;

@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,strong)VersionNumberSevice *versionNumberObject;

@end

@implementation AboutViewCtrl

-(void)viewWillAppear:(BOOL)animated{

    [self loadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title=@"关于";
    
//    [self tableViewlayout];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)loadData{

    VersionNumberSevice *app = [VersionNumberSevice new];
    [app versionNumber:^(id data) {
        
        self.dic = data;
        
        [self tableViewlayout];
//        self.versionLable.text = dic[@"version"];
        
    } failure:^(id data) {
        
    }];


}

-(void)tableViewlayout{
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"logo@2x"];
    [self.view  addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(@-100);
    }];
    
    self.versionLable = [[UILabel alloc]init];
    [self.view addSubview:self.versionLable];
    self.versionLable.textAlignment = NSTextAlignmentCenter;
    self.versionLable.font = [UIFont systemFontOfSize:16];
    self.versionLable.textColor = UIColorFromRGB(160, 160, 160);
    self.versionLable.text = [NSString stringWithFormat:@"%@.0版本",SafeString(self.dic[@"version"])];
    [self.versionLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(iconImageView.mas_bottom).offset(0);
        make.centerX.equalTo(self.view);
        make.top.equalTo(iconImageView.mas_bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@50);
    }];
    
    self.tableView = [[UITableView alloc]init];
    [self.tableView setBounces:NO];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@180);
    }];


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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //定义一个cell的ID
    static NSString *identify = @"Cell";
    //通过ID找这个Cell的队列
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    //如果在队列中找不到cell
    if (cell == nil) {
        //cell创建时调用的方法
        //设置cell的风格
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        
        //会在tableView首次显示时运行6次（把基本的所需要的cell创建出来）
        
       
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Configure the cell...
    
    UILabel *merchantsLable = [[UILabel alloc]init];
    merchantsLable.text = @"商家合作：020-38838993";
    merchantsLable.textColor = UIColorFromRGB(160, 160, 160);
    merchantsLable.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:merchantsLable];
    [merchantsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset(20);
        make.centerX.equalTo(cell.contentView);
        make.width.equalTo(@300);
        make.bottom.equalTo(cell.contentView).offset(20);
    }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    


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
