//
//  ViewController.m
//  ObjcSample
//
//  Created by Julian Gruber on 14/07/2017.
//  Copyright © 2017 Julian Gruber. All rights reserved.
//

#import "ViewController.h"

@import TwitterSearchKit;

#define kReuseIdentifier @"reuseIdentifier"

@interface ViewController ()
@property (nonatomic, strong) NSArray<NSDictionary *> *tweets;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sample App";
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kReuseIdentifier];
    
    [TSTwitterSearchKit getTweetsWithSearchTerm:@"Radiohead" :^(NSArray<NSDictionary<NSString *,id> *> * _Nullable tweets) {
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.tweets != nil) {
        return self.tweets.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
 
    // Configure the cell...
    cell.textLabel.text = @"Tweet unavailable";
    NSDictionary *tweet = self.tweets[indexPath.row];
    if(tweet != nil) {
        id textObj = tweet[@"text"];
        if([textObj isKindOfClass:NSString.class]) {
            cell.textLabel.text = (NSString *)textObj;
        }
    }
 
    return cell;
}


@end
