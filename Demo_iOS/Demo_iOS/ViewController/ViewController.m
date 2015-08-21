//
//  ViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/5/21.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "ViewController.h"
#import "TranslateViewController.h"
#import "UIViewController+CreateSelf.h"
#import "CAShapeLayerViewController.h"
#import "MapPloylineViewController.h"
#import "AutolayoutViewController.h"
#import "AutoLayoutResizingTableViewViewController.h"
#import "Demo_iOS-Bridging-Header.h"
#import "SwiftDemo-swift.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *demoList;
@property (nonatomic, strong) NSArray *demos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demos = @[@"TranslateViewController",@"CAShapeLayerViewController",@"MapPloylineViewController",@"AutolayoutViewController",@"AutoLayoutResizingTableViewViewController",@"Swift_CGAffineTransformTranslateViewController"];
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
    
    
    NSString *vc_string = self.demos[indexPath.row];
    if ([vc_string hasPrefix:@"Swift_"]) {
        vc_string = [vc_string substringFromIndex:6];
        UIViewController *v = [[CGAffineTransformTranslateViewController alloc] initWithNibName:vc_string bundle:nil];
        [self.navigationController pushViewController:v animated:YES];
    }
    else {
    
    UIViewController *v = (UIViewController *)[[NSClassFromString(vc_string) alloc] init];
    [self.navigationController pushViewController:v animated:YES];
    
    }
    
    
    
    
//    UIViewController *demo = nil;
//    
//    switch (indexPath.row) {
//        case VC_Type_Translate: {
//            demo = [TranslateViewController createSelf];
//            demo.title = self.demos[indexPath.row];
//            [self.navigationController pushViewController:demo animated:YES];
//            break;
//        }
//        case VC_Type_ShapeLayer: {
//            demo = [CAShapeLayerViewController createSelf];
//            demo.title = self.demos[indexPath.row];
//            [self.navigationController pushViewController:demo animated:YES];
//            break;
//        }
//        case VC_Type_MapPloyline: {
//            demo = [MapPloylineViewController createSelf];
//            demo.title = self.demos[indexPath.row];
//            [self.navigationController pushViewController:demo animated:YES];
//            break;
//        }
//        case VC_Type_Autolayout: {
//            demo = [AutolayoutViewController createSelf];
//            demo.title = self.demos[indexPath.row];
//            [self.navigationController pushViewController:demo animated:YES];
//            break;
//        }
//        case VC_Type_ResizeCell: {
//            demo = [AutoLayoutResizingTableViewViewController createSelf];
//            demo.title = self.demos[indexPath.row];
//            [self.navigationController pushViewController:demo animated:YES];
//            break;
//        }
//        default:
//            break;
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
