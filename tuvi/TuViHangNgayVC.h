//
//  TuViHangNgayVC.h
//  tuvi
//
//  Created by DuongND on 1/22/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "MBProgressHUD.h"

@interface TuViHangNgayVC : UIViewController <MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgIcon;
@property (strong, nonatomic) IBOutlet UILabel *lblICon;
@property (strong, nonatomic) IBOutlet UIImageView *imgTamTrang;
@property (strong, nonatomic) IBOutlet UILabel *lblTamTrang;
@property (strong, nonatomic) IBOutlet UIImageView *imgTinhYeu;
@property (strong, nonatomic) IBOutlet UILabel *lblTinhYeu;
@property (strong, nonatomic) IBOutlet UIImageView *imgTienBac;
@property (strong, nonatomic) IBOutlet UILabel *lblTienBac;
@property (strong, nonatomic) IBOutlet UIImageView *imgCongViec;
@property (strong, nonatomic) IBOutlet UILabel *lblCongViec;

@property (strong, nonatomic) IBOutlet UIView *viewSegment;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;
@property (nonatomic, strong) NSString *stringTitle;
@property (nonatomic, assign) NSInteger cID;
@end
