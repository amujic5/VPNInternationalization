//
//  VPViewController.m
//  VPInternationalization
//
//  Created by Vlaho on 03/20/2015.
//  Copyright (c) 2014 Vlaho. All rights reserved.
//

#import "VPViewController.h"
#import <VPInternationalization/VPInternationalization.h>

@interface VPViewController ()

@end

@implementation VPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)enPressed:(UIButton *)button
{
    [LocalizationManager sharedManager].language = @"en";
}

-(IBAction)frPressed:(UIButton *)button
{
    [LocalizationManager sharedManager].language = @"fr";
}

@end
