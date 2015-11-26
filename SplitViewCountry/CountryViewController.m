//
//  CountryViewController.m
//  SplitViewCountry
//
//  Created by Tatiana Kornilova on 11/24/15.
//  Copyright © 2015 Tatiana Kornilova. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
@property (strong, nonatomic) NSDictionary *countries; 
@end

@implementation CountryViewController

- (void)setCountry:(NSString *)country
{
    if (_country != country) {
        _country = country;
        
        // Update the view.
        [self updateUI];
    }
}

- (void)updateUI {
    // обновление пользовательского интерфейса
    if (self.country) {
        self.title = self.country;
        self.flagLabel.text = self.countries [self.country];
    }
}

- (void)viewDidLoad{
   [ super viewDidLoad];
       self.countries =  @{
     @"Австралия" :  @"🇦🇺",
     @"Австрия" : @"🇦🇹",
     @"Бельгия" : @"🇧🇪",
     @"Бразилия" : @"🇧🇷",
     @"Канада" : @"🇨🇦",
     @"Чили": @"🇨🇱",
     @"Япония": @"🇯🇵",
     @"Китай": @"🇨🇳",
     @"Колумбия": @"🇨🇴",
     @"Дания" : @"🇩🇰"  ,
     @"Россия" : @"🇷🇺"
     };
     [self updateUI];
}

@end
