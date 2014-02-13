//
//  TuViHangNgayVC.m
//  tuvi
//
//  Created by DuongND on 1/22/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "TuViHangNgayVC.h"
#import "UIColor+Extend.h"
#import "Dump.h"
#import "AFNetworking.h"
#import "Horoscope.h"

@interface TuViHangNgayVC ()
{
    NSMutableArray *arrayList;
}
@end

@implementation TuViHangNgayVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.stringTitle;
    arrayList = [[NSMutableArray alloc] init];
    
    [self.myScroll setHidden:YES];
    self.imgIcon.image = [UIImage imageNamed:[Dump getImageNameC:self.cID-1]];
    
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgrond.png"]]];
    [self.myScroll setBackgroundColor:[UIColor clearColor]];
    CGFloat yDelta;
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        yDelta = 20.0f;
    } else {
        yDelta = 0.0f;
    }
    
    HMSegmentedControl *segmentedControl3 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Hôm nay", @"Ngày mai"]];
    [segmentedControl3 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Selected index %i (via block)", index);
        [self setUpContent:index];
    }];
    [segmentedControl3 setSelectionIndicatorHeight:4.0f];
    [segmentedControl3 setBackgroundColor:[UIColor colorWithRed:145 green:145 blue:145 alpha:1]];
    [segmentedControl3 setFont:[UIFont systemFontOfSize:15]];
    [segmentedControl3 setTextColor:[UIColor blackColor]];
    [segmentedControl3 setSelectedTextColor:[UIColor blackColor]];
    [segmentedControl3 setSelectionIndicatorColor:[UIColor initByHexString:@"#89B349" alpha:1]];
    [segmentedControl3 setSelectionStyle:HMSegmentedControlSelectionStyleBox];
    [segmentedControl3 setSelectedSegmentIndex:HMSegmentedControlNoSegment];
    [segmentedControl3 setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    [segmentedControl3 setFrame:CGRectMake(0,0, 320, 30)];
    [segmentedControl3 setTag:2];
    [segmentedControl3 setSelectedSegmentIndex:0];
    [self.viewSegment addSubview:segmentedControl3];
    
    [self getContent:YES];
}

- (void) getContent:(BOOL) withHUD
{
    if (withHUD) {
        HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        HUD.mode = MBProgressHUDModeIndeterminate;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://tranghay.vn/xosoplus/daily_horoscopes/getDailyHoroscope?horoscope=%d",self.cID]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id JSON) {
             //NSLog(@"%@",JSON);
             @try {
                 for(NSDictionary *dict in [JSON objectForKey:@"DailyHoroscope"])
                 {
                     [arrayList addObject:[[Horoscope alloc] initWithSummary:[dict objectForKey:@"summary"]
                                                                     andmood:[dict objectForKey:@"mood"]
                                                                andmood_star:[dict objectForKey:@"mood_star"]
                                                                     andlove:[dict objectForKey:@"love"]
                                                                andlove_star:[dict objectForKey:@"love_star"]
                                                                    andmoney:[dict objectForKey:@"money"]
                                                               andmoney_star:[dict objectForKey:@"money_star"]
                                                                     andwork:[dict objectForKey:@"work"]
                                                                andwork_star:[dict objectForKey:@"work_star"]]];
                 }
                 NSLog(@"%d", arrayList.count);
                 
                 [self setUpContent:0];
             }
             @catch (NSException *exception) {
                 
             }
             @finally {
                 [HUD hide:YES];
                 [self.myScroll setHidden:NO];
             }
             //NSLog(@"1");
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             if (withHUD) {
                 [HUD hide:YES];
             } else {
                 //[self stopLoading];
             }
         }];
}
- (void) setUpContent:(NSInteger) pos
{
    Horoscope *hor = (Horoscope*)arrayList[pos];
    self.lblICon.text = hor.summary;
    
    self.imgTamTrang.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@_stars.png",hor.mood_star]];
    self.lblTamTrang.text = hor.mood;
    
    self.imgTinhYeu.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@_stars.png",hor.love_star]];
    self.lblTinhYeu.text = hor.love;
    
    self.imgTienBac.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@_stars.png",hor.money_star]];
    self.lblTienBac.text = hor.money;
    
    self.imgCongViec.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@_stars.png",hor.work_star]];
    self.lblCongViec.text = hor.work;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
