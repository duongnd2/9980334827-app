//
//  InitialViewController.m
//  tuvi
//
//  Created by DuongND on 1/22/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"centerVC"]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"leftVC"]];
    if (self) {
        // Add any extra init code here
    }
    return self;
}

@end
