//
//  GoodsNumView.m
//  lingshi
//
//  Created by chijy on 15-11-8.
//  Copyright (c) 2015年 orangelight. All rights reserved.
//

#import "NumSpanView.h"

@interface NumSpanView()

@property(nonatomic,strong) UILabel *textLabel;

@end



@implementation NumSpanView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.limitNum =99;
        
        [self makeView];
        
        
        
        
        
    }
    
    
    
    self.layer.cornerRadius=4;
    self.clipsToBounds=YES;

    
    return self;
    
}



-(void)setNum:(NSInteger)num{
    
    _num = num;
    
    self.textLabel.text = [NSString stringWithFormat:@"%ld",_num];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.textLabel.text=[NSString stringWithFormat:@"%ld",self.num];
    
    
    
}

-(void)makeView{
    
    
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [subBtn setTitle:@"－" forState:UIControlStateNormal];
    
    [subBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    subBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    subBtn.frame = CGRectMake(0, 0, 25, 25);
    
    subBtn.backgroundColor=[UIColor colorWithWhite:0.95f alpha:1.0f];
    
    [subBtn bk_addEventHandler:^(id sender) {
        
        
        UIButton *selfButton = (UIButton*)sender;
        
        UIView *uv = [selfButton superview];
        
        UILabel *lab =(UILabel*) [uv viewWithTag:1];
        
        
        NSString *numValue = lab.text;
        
        
        
        int num = [numValue intValue];
        
        if (num>1) {
            num--;
        }
        
        lab.text = [NSString stringWithFormat:@"%d",num];
        
        self.num = num;
        if (self.block) {
            self.block(num);
        }
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addBtn setTitle:@"＋" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    addBtn.frame = CGRectMake(65, 0, 25, 25);
    
    addBtn.backgroundColor=[UIColor colorWithWhite:0.9f alpha:1.0f];
    
    
    [addBtn bk_addEventHandler:^(id sender) {
        
        UIButton *selfButton = (UIButton*)sender;
        
        UIView *uv = [selfButton superview];
        
        UILabel *lab =(UILabel*) [uv viewWithTag:1];
        
        
        NSString *numValue = lab.text;
        
        int num = [numValue intValue];
        
        if (self.limitNum<(num+1)) {
            
            [SVProgressHUD showInfoWithStatus:@"库存不足，已经到达最高库存"];
            return ;
        }
        
        
        num++;
        
        
        self.num = num;
        
        
        
        lab.text = [NSString stringWithFormat:@"%d",num];
        
        if (self.block) {
            self.block(num);
        }
        
        
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 40, 25)];
    textLabel.textColor =[GUIConfig grayFontColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text=[NSString stringWithFormat:@"%ld",self.num];
    textLabel.font = [UIFont boldSystemFontOfSize:12];
    
    // self.model.goodsNumber
    textLabel.tag=1;
    
    self.textLabel = textLabel;
    
    
    
    self.layer.borderWidth=1;
    self.layer.borderColor=[[UIColor colorWithWhite:0.92f alpha:1.0f] CGColor];
    
    [self addSubview:subBtn];
    [self addSubview:self.textLabel];
    [self addSubview:addBtn];
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
