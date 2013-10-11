//
//  HBViewController.m
//  HBDragableButton
//
//  Created by Hilal Baig on 11/10/2013.
//  Copyright (c) 2013 Hilal Baig. All rights reserved.
//  https://www.facebook.com/hilalbaig
//
//  Our Products at Appstore
//  https://www.facebook.com/iphraseapp
//  https://www.facebook.com/angrydrawingapp
//  We value your Downloads and Reviews..
//
//  This file is part of the UICircularSlider Library, released under the MIT License.
//



#import "HBViewController.h"

@interface HBViewController ()

@property BOOL isDraging;

@end

@implementation HBViewController

@synthesize isDraging;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isDraging = NO;
    
    
	// create a new button
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:@"Drag or Tap" forState:UIControlStateNormal];
    
	// add drag listener
	[button addTarget:self action:@selector(wasDragged:withEvent:)
     forControlEvents:UIControlEventTouchDragInside];
    
	// add tap listener
	[button addTarget:self action:@selector(wasTapped:)
     forControlEvents:UIControlEventTouchUpInside];
    
	// center and size
	button.frame = CGRectMake((self.view.bounds.size.width - 100)/2.0,
                              (self.view.bounds.size.height - 50)/2.0,
                              100, 50);
    
	// add it, centered
	[self.view addSubview:button];
    
    [button addTarget:self action:@selector(dragBegan:withEvent:) forControlEvents: UIControlEventTouchDown];
    [button addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents: UIControlEventTouchDragInside];
    [button addTarget:self action:@selector(dragEnded:withEvent:) forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    
    
}

- (void)dragBegan:(UIControl *)c withEvent:ev {
    isDraging = NO;
}

- (void)dragMoving:(UIControl *)c withEvent:ev {
    isDraging = YES;
}

- (void)dragEnded:(UIControl *)c withEvent:ev {
    isDraging = NO;
}


- (void)wasTapped:(UIButton *)button
{
    if (isDraging == NO) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Tapped"
                                  message:@"Buton tapped!"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        
    }
}

- (void)wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
    
    
	// get the touch
	UITouch *touch = [[event touchesForView:button] anyObject];
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:button];
	CGPoint location = [touch locationInView:button];
	CGFloat delta_x = location.x - previousLocation.x;
	CGFloat delta_y = location.y - previousLocation.y;
    
	// move button
	button.center = CGPointMake(button.center.x + delta_x,
                                button.center.y + delta_y);
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
