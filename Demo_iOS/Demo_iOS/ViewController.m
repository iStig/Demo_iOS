//
//  ViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/5/21.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "ViewController.h"
#import "TranslateViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *demoList;
@property (nonatomic, strong) NSArray *demos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demos = @[@"Translate"];
    // Do any additional setup after loading the view, typically from a nib.
    [self.demoList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DemoCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DemoList"];
    }
    cell.textLabel.text = self.demos[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demos.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *demo = nil;
    
    switch (indexPath.row) {
        case VC_Type_Translate:{
            demo = [[TranslateViewController alloc] init];
            demo.title = self.demos[indexPath.row];
            [self.navigationController pushViewController:demo animated:YES];
        }
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
