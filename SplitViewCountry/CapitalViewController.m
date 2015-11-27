//
//  CapitalViewController.m
//  Photomania
//
//

#import "CapitalViewController.h"

@interface CapitalViewController ()
@property (weak, nonatomic) IBOutlet UITextView *capitalTextView;
@end

@implementation CapitalViewController

- (void)setCapital:(NSString *)capital
{
    _capital = capital;
    [self updateUI];
}

// updateUI работает здесь, если свойство capital
// устанавливается перед загрузкой outlets
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI {

    self.capitalTextView.text = self.capital;
}

-(CGSize)preferredContentSize {
    if (self.capitalTextView != nil && self.presentingViewController != nil ) {
        return [self.capitalTextView
                   sizeThatFits:self.presentingViewController.view.bounds.size];
    }
        else {
            return super.preferredContentSize;
        }
}

@end
