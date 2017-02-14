// TableViewController.m
// 
// Copyright (c) 2017年 hbzs
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "TableViewController.h"
#import "DataSource.h"

NSString *const kDemoListTableViewCellIdentifier = @"kDemoListTableViewCellIdentifier";

@implementation TableViewController

#pragma mark - view lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDemoListTableViewCellIdentifier];
}


#pragma mark - data source & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [DataSource sharedDataSource].dataItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDemoListTableViewCellIdentifier forIndexPath:indexPath];
  
  cell.textLabel.text   = [DataSource sharedDataSource].dataItems[indexPath.row];
  cell.accessoryType    = UITableViewCellAccessoryDisclosureIndicator;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  UIViewController *viewController;
  NSString *dataItem = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
  
  NSArray *dataItems = [DataSource sharedDataSource].dataItems;
  for (int rowAtData = 0; rowAtData < dataItems.count; rowAtData++) {
    if ([dataItems[rowAtData] isEqualToString:dataItem]) {
      
      NSString *nameWithViewController = [NSString stringWithFormat:@"%@ViewController", [[DataSource sharedDataSource] titleByDataItem:dataItem]];
      viewController                   = [[NSClassFromString(nameWithViewController) alloc] init];
      viewController.title             = dataItem;
      
      break;
    }
  }
  [self.navigationController pushViewController:viewController animated:YES];
}

@end
