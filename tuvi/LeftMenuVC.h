//
//  LeftMenuVC.h
//  tuvi
//
//  Created by DuongND on 1/21/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "GADBannerView.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface LeftMenuVC : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) IBOutlet UILabel *lblXu;
@end
