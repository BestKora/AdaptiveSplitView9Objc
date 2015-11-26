//
//  SelectContinentTableViewController.m
//  SplitViewCountry
//
//  Created by Tatiana Kornilova on 11/25/15.
//  Copyright © 2015 Tatiana Kornilova. All rights reserved.
//

#import "SelectContinentTableViewController.h"
#import "SelectCountryTableViewController.h"

@interface SelectContinentTableViewController ()
@property (strong, nonatomic) NSDictionary *countries;
@property (strong, nonatomic) NSArray *continents;

@end

@implementation SelectContinentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countries =  @{
                        @"Австралия" :  @[@"Австралия"],
                        @"Европа" : @[@"Австрия",@"Бельгия", @"Дания", @"Россия"],
                        @"Южная Америка" :@[ @"Бразилия", @"Чили", @"Колумбия"],
                        @"Северная Америка" :@[ @"Канада"],
                        @"Азия" :@[ @"Япония", @"Китай"]

                        };
    self.continents = self.countries.allKeys;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.continents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"continentCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.continents objectAtIndex:indexPath.row];
    return cell;

    
    return cell;
}





#pragma mark - Navigation

 - (void)prepareViewController:(id)vc
 forSegue:(NSString *)segueIdentifer
 fromIndexPath:(NSIndexPath *)indexPath
 {
     NSString * continent = self.continents[indexPath.row];
     NSArray *countries = self.countries[continent];
 id ivc = vc;
 if ([vc isKindOfClass:[UINavigationController class]]) {
 ivc = [(UINavigationController  *)vc topViewController];
 }
 
 if ([ivc isKindOfClass:[SelectCountryTableViewController class]]) {
 ((SelectCountryTableViewController *)ivc).countries = countries;
 
 
 }
 }
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 NSIndexPath *indexPath = nil;
 if ([sender isKindOfClass:[UITableViewCell class]]) {
 indexPath = [self.tableView indexPathForCell:sender];
 }
 [self prepareViewController:segue.destinationViewController
 forSegue:segue.identifier
 fromIndexPath:indexPath];
 }
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
