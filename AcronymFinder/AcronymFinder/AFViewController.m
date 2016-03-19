//
//  ViewController.m
//  AcronymFinder
//
//  Created by Randhir Kumar on 3/19/16.
//  Copyright © 2016 @Randhir Kumar. All rights reserved.
//

#import "AFViewController.h"
#import  "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AFAcronymDataController.h"
#import "AFAFAcronymDataModel.h"
#import "AFMeaningDataModel.h"
#import "AFDetailVariationViewController.h"


@interface AFViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *acronymTableView;
@property (strong, nonatomic) IBOutlet UITextField *acronymSearchTextField;
@property (strong, nonatomic) NSString *acronymString;
@property (strong,nonatomic) AFAcronymDataController *dataController;
@property (strong,nonatomic)AFAFAcronymDataModel*dataModel;
@property (strong,nonatomic)AFMeaningDataModel *meaningDataModel;
@property (strong, nonatomic) IBOutlet UILabel *meaningLabel;



@property(strong) NSArray *acronymDict;


@end

@implementation AFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataController = [[AFAcronymDataController alloc] init];
    
    self.acronymString = @"sf";
    
    self.acronymTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fresh-green-background.jpg"]];

}

#pragma mark - UITextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  self.acronymSearchTextField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.acronymSearchTextField resignFirstResponder];
    if(![textField.text isEqualToString:@""]){
        
        [self getMeaningForAcronym:self.acronymSearchTextField.text];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    return YES;
    
}


-(void)getMeaningForAcronym:(NSString*)acronym
{
        
    [self.dataController getURLResponse:acronym gotData:^(NSURLSessionTask *task, AFAFAcronymDataModel *baseDataModel) {
        self.dataModel = baseDataModel;
        if (self.dataModel && self.dataModel.lfs.count > 0) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSString *meaningLabelString = [NSString stringWithFormat:@"%@ %@ ",@"Meanings of",self.acronymSearchTextField.text];
            self.meaningLabel.text = meaningLabelString;
            [self.acronymTableView reloadData];
        }
        else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
              self.meaningLabel.text = @"";
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self dismissViewControllerAnimated: YES completion: nil];}];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Meaning Found !!" message:@"There is no meaning for this acronym,please search another acronym"preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            [self.acronymTableView reloadData];
        }

        
    } failed:^(NSURLSessionTask *task, NSError *error) {
        
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return [self.dataModel.lfs count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"acronymcellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   AFMeaningDataModel *meaningDataModel = [self.dataModel.lfs objectAtIndex:indexPath.row];
    cell.textLabel.text =     meaningDataModel.lfWordMeaning;
    
    
    return cell;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"detailVariations"]) {
        NSIndexPath *indexPath = [self.acronymTableView indexPathForSelectedRow];
        AFDetailVariationViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.lfWordMeaning = [self.dataModel.lfs objectAtIndex:indexPath.row];
    }
    
}


@end
