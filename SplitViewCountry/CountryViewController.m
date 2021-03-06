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
        //   (поэтому удаляем Capital, если кто-то изменил country)
        
        //---iOS 8 и iOS 9----
        
        if (self.presentedViewController) {
            [self.presentedViewController
                        dismissViewControllerAnimated:YES completion:nil];
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
                    @"Колумбия": @"Санта-Фа-Де-Богота",
                    @"Дания" : @"Копенгаген"  ,
                    @"Россия" : @"Москва"
                    };

     [self updateUI];
}

// показываем наш capital в popover
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
- (IBAction)filterImage:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Filter Image"
                                message:@"Choose filter."
                                preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *filter in [self filters]) {
        UIAlertAction *filterAction = [UIAlertAction
                                       actionWithTitle:filter
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //                       self.image = [self.image imageByApplyingFilterNamed:self.filters[action.title]];
                                           NSLog(@"You pressed button %@", self.filters[action.title]);
                                       }];
        [alert addAction:filterAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action) {
                                       NSLog(@"You pressed button Cancel");
                                   }];
    [alert addAction:cancelAction];
    
    alert.modalPresentationStyle = UIModalPresentationPopover; //  for iPad
    UIPopoverPresentationController *ppc = alert.popoverPresentationController; //  for iPad
    if (ppc)
    {
        ppc.sourceView = sender;
        ppc.sourceRect = sender.bounds;
        ppc.permittedArrowDirections = UIPopoverArrowDirectionAny;
        
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSDictionary *)filters
{
    return @{ @"Chrome" : @"CIPhotoEffectChrome",
              @"Blur"   : @"CIGaussianBlur",
              @"Noir"   : @"CIPhotoEffectNoir",
              @"Fade"   : @"CIPhotoEffectFade" };
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:
                                              (UIPresentationController *)controller
                              traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}

@end
