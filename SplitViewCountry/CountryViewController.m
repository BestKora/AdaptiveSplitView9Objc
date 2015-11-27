//
//  CountryViewController.m
//  SplitViewCountry
//
//  Created by Tatiana Kornilova on 11/24/15.
//  Copyright © 2015 Tatiana Kornilova. All rights reserved.
//

#import "CountryViewController.h"
#import "CapitalViewController.h"

@interface CountryViewController ()<UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
@property (strong, nonatomic) NSDictionary *flags;
@property (strong, nonatomic) NSDictionary *capitals;

@end

@implementation CountryViewController

- (void)setCountry:(NSString *)country
{
    if (_country != country) {
        _country = country;
        
        // Обновляем View.
        [self updateUI];
    }
}

- (void)updateUI {
    // обновление пользовательского интерфейса
    if (self.country) {
        self.title = self.country;
        self.flagLabel.text = self.flags [self.country];
        
        // в портретной ориентации на iPad в split view,
        //   к сожалению, master может быть доступен при открытом Popover
        //   (поэтому удаляем Capital, если кто-то изменил country и мы попадаем в этот setter)
        
        //---iOS 8 и iOS 9----
        if (self.presentedViewController) {
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)viewDidLoad{
   [ super viewDidLoad];
       self.flags =  @{
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
    self.capitals =  @{
                    @"Австралия" :  @"Канберра",
                    @"Австрия" : @"Вена",
                    @"Бельгия" : @"Брюссель",
                    @"Бразилия" : @"Бразилиа",
                    @"Канада" : @"Оттава",
                    @"Чили": @"Сантьяго",
                    @"Япония": @"Токио",
                    @"Китай": @"Пекин",
                    @"Колумбия": @"Санта-Фе-де-Богота",
                    @"Дания" : @"Копенгаген"  ,
                    @"Россия" : @"Москва"
                    };

     [self updateUI];

// показываем наш capital в popover
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[CapitalViewController class]]) {
        
        CapitalViewController *urlvc =
                               (CapitalViewController *)segue.destinationViewController;
        urlvc.capital = self.capitals [self.country];
        
        if (urlvc.popoverPresentationController) {
               UIPopoverPresentationController *ppc = urlvc.popoverPresentationController;
               ppc.delegate = self;
        }
        
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:
                                              (UIPresentationController *)controller
                              traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}

@end
