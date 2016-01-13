//
//  AppDelegate.m
//  SplitViewCountry
//
//  Created by Tatiana Kornilova on 11/24/15.
//  Copyright © 2015 Tatiana Kornilova. All rights reserved.
//

#import "AppDelegate.h"
#import "CountryViewController.h"
#import "SelectCountryTableViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
                            didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UISplitViewController *splitViewController =
                           (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController =
                            [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem =
                                          splitViewController.displayModeButtonItem;
    navigationController.topViewController.navigationItem.leftItemsSupplementBackButton = YES;
    
    splitViewController.preferredDisplayMode =  UISplitViewControllerDisplayModeAllVisible;
    
    // splitViewController.preferredPrimaryColumnWidthFraction = 0.5;
    // splitViewController.maximumPrimaryColumnWidth = 512;
    

    
    splitViewController.delegate = self;

    return YES;
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
              collapseSecondaryViewController:(UIViewController *)secondaryViewController
                        ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    if ([secondaryViewController isKindOfClass:[UINavigationController class]]){
        
        if ([[(UINavigationController *)secondaryViewController topViewController]
             isKindOfClass:[CountryViewController class]]) {
            
            
            if ([(CountryViewController *)[(UINavigationController *)secondaryViewController
                                           topViewController] country] == nil) {
                
                // возврат YES показывает, что мы управляем отбрасыванием Detail
                // не делая ничего мы его и отбрасывам
                return YES;
            }
        }
    }
    
    return NO;
}


- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController {
    
    if ([primaryViewController isKindOfClass:[UINavigationController class]]) {
        if ( [[(UINavigationController *)primaryViewController topViewController]
                                             isKindOfClass:[SelectCountryTableViewController class]]) {
            
            SelectCountryTableViewController *countriesView = (SelectCountryTableViewController *)
                                     [(UINavigationController *)primaryViewController topViewController];
            //-------- autoselectedCountry----
            NSArray * countries = countriesView.countries;
            NSString *country = countries.firstObject;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
           [countriesView.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:0];
            //-------- autoselectedCountry----

            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *detailView =
                                [storyboard instantiateViewControllerWithIdentifier:@"detailNavigation"];
            
            // Обеспечиваем появление обратной кнопки и настройку Модели
            CountryViewController *controller = (CountryViewController *)[detailView visibleViewController];
            controller.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
            controller.navigationItem.leftItemsSupplementBackButton = YES;
            controller.country =country;
            
            return detailView;
        }
    }
    return  nil;
}


@end
