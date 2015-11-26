//
//  SelectCountryTableViewController.m
//  SplitViewCountry
//
//  Created by Tatiana Kornilova on 11/24/15.
//  Copyright © 2015 Tatiana Kornilova. All rights reserved.
//

#import "SelectCountryTableViewController.h"
#import "CountryViewController.h"

@interface SelectCountryTableViewController ()


@end

@implementation SelectCountryTableViewController

- (void)setCountries:(NSArray *)countries
{
    if (_countries != countries) {
        _countries = countries;
        
        // Update the view.
        [self updateUI];
    }
}
- (void)updateUI {
    // обновление пользовательского интерфейса
    [self.tableView reloadData];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
/*    self.countries =
    @[@"Австралия", @"Австрия" ,@"Бельгия", @"Бразилия",@"Канада",
      @"Чили", @"Китай", @"Колумбия", @"Дания", @"Россия", @"Япония"]; */
    [self updateUI];
}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
                          numberOfRowsInSection:(NSInteger)section {
    
    return self.countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
            [tableView dequeueReusableCellWithIdentifier:@"countryCell"];
    cell.textLabel.text = [self.countries objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Navigation

- (void)prepareViewController:(id)vc
                     forSegue:(NSString *)segueIdentifer
                fromIndexPath:(NSIndexPath *)indexPath
{
    NSString *country = self.countries[indexPath.row];
    id ivc = vc;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        ivc = [(UINavigationController  *)vc topViewController];
    }
    
    if ([ivc isKindOfClass:[CountryViewController class]]) {
        ((CountryViewController *)ivc).country = country;
        
        ((CountryViewController *)ivc).navigationItem.leftBarButtonItem =
                                       self.splitViewController.displayModeButtonItem;
        ((CountryViewController *)ivc).navigationItem.leftItemsSupplementBackButton =
                                                                                   YES;
        
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detailvc = [self.splitViewController.viewControllers lastObject];
    if ([detailvc isKindOfClass:[UINavigationController class]]) {
        detailvc = [((UINavigationController *)detailvc).viewControllers firstObject];
    }
        [self prepareViewController:detailvc
                           forSegue:nil
                      fromIndexPath:indexPath];
    }
*/
   
@end

