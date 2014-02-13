//
//  DetailListTuViVC.m
//  tuvi2014
//
//  Created by DuongND on 1/20/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "DetailListTuViVC.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface DetailListTuViVC ()
{
    NSMutableArray *arrayList;
}
@end

@implementation DetailListTuViVC

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
    // Do any additional setup after loading the view from its nib.
    arrayList = [[NSMutableArray alloc] init];
    [self disPlayAdd];
    if (self.cID == 1123) {
        self.title = self.stringTitle;
        [self.myWebView loadHTMLString:self.stringDetail baseURL:nil];
    }else{
        //[self getDataToArrayList:self.cID];
        self.title = self.stringTitle;
        [self.myWebView loadHTMLString:[self getDataToArrayList:self.cID] baseURL:nil];
    }
    

}

- (void) disPlayAdd{
    GADBannerView *bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    bannerView_.adUnitID = @"a152df8a25c4221";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = self;
    
    GADRequest * request = [GADRequest request];
    //request.testDevices = [NSArray arrayWithObjects:@"cbe917cfd5a5dc834dda707bc37a5938", nil];
    
    // Initiate a generic request to load it with an ad.
    [bannerView_ loadRequest:request];
    [self.viewADDDDD addSubview:bannerView_];
}

- (NSString*) getDataToArrayList:(NSInteger) cID;
{
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"tuvi2014-db-main.sqlite"];
    
    NSString *strFullDetai;
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    
    [database open];
    //NSString *sqlSelectQuery = @"SELECT * FROM tbl_age WHERE category_id ";
    NSString *sqlSelectQuery = [NSString stringWithFormat:@"SELECT * FROM tbl_horoscope WHERE id = '%d'", cID];;
    
    NSLog(@"SELECT QUERY OUTPUT");
    
    // Query result
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        
        strFullDetai = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"full_detail"]];
        
        
    }
    [database close];
    
    return strFullDetai;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
