//
//  FontTableViewController.m
//  Demo_iOS
//
//  Created by iStig on 15/9/2.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "FontTableViewController.h"

static const NSString *kFontFamilyName = @"fontFamilyName";
static const NSString *kFontName = @"fontName";
static NSString * const kIdentifier = @"identifier";

@interface FontTableViewController ()
@property (nonatomic, strong) NSMutableArray *fontDataSource;
@end

@implementation FontTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kIdentifier];
    
    _fontDataSource = [self fetchFonts];
}

- (NSMutableArray *)fetchFonts {
    NSMutableArray *fonts = @[].mutableCopy;
    
    for(NSString *fontFamilyName in [UIFont familyNames]) {
        NSMutableDictionary *fontCategory = @{}.mutableCopy;
        NSMutableArray *fontsName =@[].mutableCopy;
        
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
            [fontsName addObject:fontName];
        }
        
        fontCategory[kFontFamilyName] = fontFamilyName;
        fontCategory[kFontName] = fontsName;
        [fonts addObject:fontCategory];
    }
    return fonts;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)fontTitle:(NSInteger)index {
    NSDictionary *fontCategory = [_fontDataSource objectAtIndex:index];
    NSString *font = fontCategory[kFontFamilyName];
    return font;
}

- (NSArray* )fontList:(NSInteger)index {
    NSDictionary *fontCategory = [_fontDataSource objectAtIndex:index];
    NSArray *fontList = fontCategory[kFontName];
    return fontList;
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _fontDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self fontList:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    
    NSArray *fonts = [self fontList:indexPath.section];
    NSString *fontName = [fonts objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:fontName size:20];
    cell.textLabel.text = fontName;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self fontTitle:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *fonts = [self fontList:indexPath.section];
    NSString *fontName = [fonts objectAtIndex:indexPath.row];
    
    NSLog(@"%@",fontName);
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
