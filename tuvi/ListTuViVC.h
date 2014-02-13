//
//  ListTuViVC.h
//  tuvi2014
//
//  Created by DuongND on 1/20/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

@interface ListTuViVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (nonatomic, assign) NSInteger cID;
@property (nonatomic, assign) NSInteger category_ID;
@property (strong, nonatomic) IBOutlet UIView *viewADDD;
@property (nonatomic, strong) NSString *stringTitle;
@end
