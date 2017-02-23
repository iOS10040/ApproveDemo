//
//  ViewController.m
//  TableViewDemo
//
//  Created by iOSDeveloper on 2017/2/22.
//  Copyright © 2017年 iOSDeveloper. All rights reserved.
//

#import "ViewController.h"
#import "SXToolBarMessageModel.h"
#import "SXToolBarMessageCell.h"
#import "HeaderView.h"
#import "SXEditPanelView.h"

#define FRScreenW [UIScreen mainScreen].bounds.size.width
#define FRScreenH [UIScreen mainScreen].bounds.size.height
//当前设备与iphone5的宽、高缩放比例
#define SCALE_IPHONE5_W (FRScreenW) / 320.0
#define SCALE_IPHONE5_H (FRScreenH) / 568.0

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SXEditPanelViewDelegate>

@property(nonatomic,weak)UITableView *tableView;

//新闻数据
@property (nonatomic,strong) NSMutableArray *newsList;
/**遮罩视图*/
@property(nonatomic,strong)UIControl *maskView;
/**分享面板*/
@property(nonatomic,strong)SXEditPanelView *editPanelView;

@end

#define SXCell_Mark @"SXToolBarMessageCell" // Cell重用标识符
@implementation ViewController

#pragma mark - 懒加载
- (NSMutableArray *)newsList{
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    [self loadData];
    
    [self createSubViews];
}

- (void)loadData{
    for (int i=0; i<10; i++) {
        SXToolBarMessageModel *model = [[SXToolBarMessageModel alloc]init];
        model.goods = @"移动硬盘";
        model.price = @"400";
        model.amount = @"4";
        model.money = @"1600元";
        [self.newsList addObject:model];
    }
}

- (void)createSubViews{
    //表视图的头
    UIView *bgView = [ [UIView alloc]init];
    bgView.frame = CGRectMake(0, 60, FRScreenW, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    //报销总金额
    UILabel *myLabel = [self setUpLabelWithTextColor:[UIColor blackColor] fontSize:17.0 superView:bgView text:[NSString stringWithFormat:@"报销总金额："]];
    myLabel.frame    = CGRectMake(10,5,FRScreenW,(40-10)/2.0);
    [myLabel sizeToFit];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.frame =  CGRectMake(0, CGRectGetMaxY(bgView.frame)+1, FRScreenW, 160);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor lightGrayColor];
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 ){
        tableView.rowHeight = 45 * SCALE_IPHONE5_H;
        tableView.estimatedRowHeight = 45 * SCALE_IPHONE5_H;
    }else {
        tableView.rowHeight = 45 * SCALE_IPHONE5_H;
    }
    
    [self.view addSubview:_tableView = tableView];
    
    //注册单元格
    [_tableView registerNib:[UINib nibWithNibName:SXCell_Mark bundle:nil] forCellReuseIdentifier:SXCell_Mark];
    
    //费用明细的背景
    UIView *bottomView = [ [UIView alloc]init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(tableView.frame)+1, FRScreenW, 40);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //费用明细
    UIButton *myBtn = [self setUpButtonWithBgImg:nil superView:bottomView action:@selector(btnAction:) title:@"+费用明细"];
    myBtn.frame     = CGRectMake(FRScreenW-80-10,5,80,30);
    myBtn.backgroundColor = [UIColor blueColor];
    
    //分享面板
//    SXEditPanelView *editPanelView = [[[NSBundle mainBundle]loadNibNamed:@"SXEditPanelView"
//                                         owner:self
//                                       options:nil]lastObject];
    SXEditPanelView *editPanelView = [SXEditPanelView sxeditPanelView];
    editPanelView.frame = CGRectMake((FRScreenW - 229)/2,  FRScreenH, 229, 165);
    //editPanelView.backgroundColor = [UIColor redColor];
    editPanelView.userInteractionEnabled = YES;//允许交互
    editPanelView.layer.cornerRadius = 10;
    editPanelView.layer.masksToBounds = YES;
    editPanelView.sxEditPanelVDelegate = self;
    [self.view addSubview:editPanelView];
    self.editPanelView = editPanelView;
    
}

#pragma mark - 创建button
- (UIButton *)setUpButtonWithBgImg:(UIImage *)bgImg superView:(UIView *)superView action:(SEL)action title:(NSString *)title{
    UIButton *btn            = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.layer.cornerRadius   = 3;
    [btn setBackgroundImage:bgImg forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font      = [UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];
    return btn;
}
#pragma mark - 添加费用明细事件
- (void)btnAction:(UIButton *)sender{
//    SXToolBarMessageModel *model = [[SXToolBarMessageModel alloc]init];
//    model.goods = @"移动硬盘";
//    model.price = @"400";
//    model.amount = @"5";
//    model.money = @"1600元";
//    [self.newsList addObject:model];
//    [self.tableView reloadData];
    
    [self createMaskView];
}

#pragma mark - 创建遮罩视图
- (void)createMaskView{
    if (!_maskView) {
        _maskView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, FRScreenW, FRScreenH)];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
        [_maskView addTarget:self action:@selector(maskAction) forControlEvents:UIControlEventTouchUpInside];
        //[self.view addSubview:_maskView];
        [self.view insertSubview:_maskView belowSubview:self.editPanelView];
    }
    //面板上移
    [UIView animateWithDuration:0.35 animations:^{
        self.editPanelView.transform = CGAffineTransformMakeTranslation(0, -FRScreenH+70);
    }];
    _maskView.hidden = NO;
}
//遮罩视图的点击事件
- (void)maskAction{
    NSLog(@"您点击了遮罩视图");
    _maskView.hidden = YES;
    [self.view endEditing:YES];
    
    //分享面板下移
    [UIView animateWithDuration:0.35 animations:^{
        self.editPanelView.transform = CGAffineTransformMakeTranslation(0, FRScreenH-70);
    }];
    
}

#pragma mark -创建label
- (UILabel *)setUpLabelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize superView:(UIView *)superView text:(NSString *)text{
    UILabel *label      = [[UILabel alloc] init];
    label.textColor     = textColor;
    label.font          = [UIFont systemFontOfSize:fontSize];
    label.text          = text;
    [superView addSubview:label];
    return label;
}

#pragma mark - UITableViewDataSourc
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SXToolBarMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:SXCell_Mark];
    
    if (!cell) {
        cell = [[SXToolBarMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SXCell_Mark];
    }
    
    SXToolBarMessageModel *model = self.newsList[indexPath.row];
    cell.model = model;
    
    UIButton *editBtn = cell.editBtn;
    [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

//编辑单元格
- (void)editBtnAction:(UIButton *)sender{
    //点击tablecell中的一个按钮，确定cell所在的行
    //获取父类view
    UIView *v = [sender superview];
    //获取cell
    SXToolBarMessageCell *cell = (SXToolBarMessageCell *)[v superview];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    [self.newsList removeObjectAtIndex:indexpath.row];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
//头视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderView *view = nil;
    if (section == 0) {
        //如何从xib文件加载视图?
        view = [[[NSBundle mainBundle]loadNibNamed:@"HeaderView"
                                                    owner:self
                                                  options:nil]lastObject];
        //view.frame=CGRectMake(0, 0, FRScreenW, 36);
    }
    return view;
    
}

#pragma mark - SXEditPanelViewDelegate
- (void)inputFinished:(NSMutableDictionary *)dic{
    NSLog(@"传出来的值为:%@",dic);
    
    SXToolBarMessageModel *model = [[SXToolBarMessageModel alloc]init];
    model.goods = [dic valueForKey:@"goods"];
    model.price = [dic valueForKey:@"price"];
    model.amount = [dic valueForKey:@"amount"];
    model.money = [dic valueForKey:@"money"];
    [self.newsList addObject:model];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
