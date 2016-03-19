//
//  AFDetailVariationViewController.m
//  AcronymFinder
//
//  Created by Randhir Kumar on 3/19/16.
//  Copyright © 2016 @Randhir Kumar. All rights reserved.
//

#import "AFDetailVariationViewController.h"

@interface AFDetailVariationViewController()

@property (strong, nonatomic) IBOutlet UITableView *variationTableView;


@end

@implementation AFDetailVariationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.variationTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fresh-green-background.jpg"]];

    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
    
    NSString *string = [NSString stringWithFormat:@"%@ %@",@"Variations of",self.lfWordMeaning.lfWordMeaning];
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; 
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lfWordMeaning.var.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"variationsCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AFMeaningDataModel *lfWordmeaning = [self.lfWordMeaning.var objectAtIndex:indexPath.row];
    
    cell.textLabel.text = lfWordmeaning.lfWordMeaning;
    cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"First used in %ld with a frequency of %ld", @""),(long)lfWordmeaning.since, (long)lfWordmeaning.frequency];
    
    
    return cell;
}


@end
