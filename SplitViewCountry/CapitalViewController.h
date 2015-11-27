//
//  CapitalViewController.h
//  Photomania
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapitalViewController : UIViewController

// показывает url
// это специализированный popover класс
// он будет работать в любой среде
// (например, для push в navigation controller)

@property (nonatomic, strong) NSString *capital;

@end
