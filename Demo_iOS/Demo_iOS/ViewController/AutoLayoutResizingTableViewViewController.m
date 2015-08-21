//
//  AutoLayoutResizingTableViewViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/8/4.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "AutoLayoutResizingTableViewViewController.h"
#import "ResizingTableViewCell.h"
#import "UIView+loadFromNib.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString * const kResizingCell = @"ResizingCell";

@interface AutoLayoutResizingTableViewViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableDictionary *offscreenCells;
@end

@implementation AutoLayoutResizingTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataSource = @[@"初始化解析的类，这个类通常带一个URL 参数，可能还有一个扩展参数，例如查询参数， 用block作为参数进行回调显示成功还是失败，如果成功则返回已经解析好的结果，如果失败则返回失败的原因",
                        @"只是简单的做了初始化，［self refreshData]用这个已经初始化的类来从服务器下载数据并返回结果，当然解析好之后在返回更好",
                        @"配置cell时要注意如果有图片需要先清除原有的图片"];
    self.offscreenCells = [NSMutableDictionary dictionary];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[ResizingTableViewCell nib] forCellReuseIdentifier:kResizingCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResizingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResizingCell forIndexPath:indexPath];
    cell.content.text = self.dataSource[indexPath.row];
    cell.subContent.text = self.dataSource[indexPath.row];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  //当用xib布局的时候用这个
    ResizingTableViewCell *cell = [self.offscreenCells objectForKey:kResizingCell];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:kResizingCell];
        [self.offscreenCells setObject:cell forKey:kResizingCell];
    }
    
    cell.content.text = self.dataSource[indexPath.row];
    cell.subContent.text = self.dataSource[indexPath.row];
    
    //    [cell prepareForReuse]; //不是必须
    
    NSLayoutConstraint *tempWidthConstraint =
    [NSLayoutConstraint constraintWithItem:cell.contentView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:CGRectGetWidth(self.tableView.bounds)];
    [cell.contentView addConstraint:tempWidthConstraint];
    
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    //    [cell.contentView removeConstraint:tempWidthConstraint]; //不是必须
    return height;
    
    
    //当使用代码布局的时候用这个
    
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    
//    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(cell.bounds));
//    
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
    
    

    
    
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
