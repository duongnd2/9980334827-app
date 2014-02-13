//
//  ListTuViVC.m
//  tuvi2014
//
//  Created by DuongND on 1/20/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "ListTuViVC.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "UIColor+Extend.h"
#import "Dump.h"
#import "DetailListTuViVC.h"

@interface ListTuViVC ()
{
    NSMutableArray *arrayList;
}
@property (nonatomic, strong) DetailListTuViVC *detalsList;
@end

@implementation ListTuViVC

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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:nil];
    
    [self disPlayAdd];
    NSArray *array = [self.stringTitle componentsSeparatedByString:@" "]; // Split String
    NSLog(@"cID is %d", self.cID);
    switch (self.cID) {
        case 0:
            self.title = [NSString stringWithFormat:@"Tử vi tuổi %@ 2014", array[1]];
            break;
        case 1:
            self.title = [NSString stringWithFormat:@"Tử vi trọn đời tuổi %@", array[1]];
            break;
        default:
            break;
    }
    //self.title = [NSString stringWithFormat:@"Tử vi tuổi %@ 2014", array[1]];
    
    arrayList = [[NSMutableArray alloc] init];
    
    [self getDataToArrayList:self.category_ID];
    
    
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
    [self.viewADDD addSubview:bannerView_];
}
- (void) getDataToArrayList:(NSInteger) cID;
{
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"tuvi2014-db-main.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    
    [database open];
    //NSString *sqlSelectQuery = @"SELECT * FROM tbl_age WHERE category_id ";
    NSString *sqlSelectQuery;
    
    switch (self.cID) {
        case 0:
            sqlSelectQuery = [NSString stringWithFormat:@"SELECT * FROM tbl_age WHERE category_id = '%d'", cID];
            break;
        case 1:
            sqlSelectQuery = [NSString stringWithFormat:@"SELECT * FROM tbl_age_lifetime WHERE category_id = '%d'", cID];
            break;
        default:
            break;
    }
    
    NSLog(@"SELECT QUERY OUTPUT");
    
    // Query result
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        
        // Accessing the values from the column.
        NSString *strName = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"name"]];
        NSString *strGender = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"gender"]];
        
        NSString *strTitle = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"title"]];
        
        NSString *strBirth = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"birth"]];
        
        NSString *strFullDetai = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"full_detail"]];
        
        [arrayList addObject:[NSString stringWithFormat:@"%@----%@----%@----%@----%@",strName,strGender,strBirth,strFullDetai,strTitle]];
        
    }
    [database close];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Use the default cell style.
        cell = [[UITableViewCell alloc] initWithStyle : UITableViewCellStyleSubtitle
                                      reuseIdentifier : CellIdentifier];
    }
    
    //[cell setBackgroundColor:[UIColor initByHexString:@"#685e55" alpha:1.0]];
    
    NSString *cellValue = [arrayList objectAtIndex:indexPath.row];
    NSArray *array = [cellValue componentsSeparatedByString:@"----"]; // Split String
    
    UIImage* theImage = [UIImage imageNamed:[Dump getImageName:self.category_ID-1]];
    cell.imageView.image = theImage;
    BOOL isNam;
    
    if ([array[1] isEqualToString:@"0"]) {
        isNam = YES;
    }else{
        isNam = NO;
    }
    NSString *title = [NSString stringWithFormat:@"Tuổi %@ - %@", array[0], isNam ? @"Nam Mạng" : @"Nữ Mạng"];
    cell.textLabel.text = title;
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    
    cell.detailTextLabel.text = array[2];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellValue = [arrayList objectAtIndex:indexPath.row];
    NSArray *array = [cellValue componentsSeparatedByString:@"----"]; // Split String
    BOOL isNam;
    
    if ([array[1] isEqualToString:@"0"]) {
        isNam = YES;
    }else{
        isNam = NO;
    }
    NSString *title = [NSString stringWithFormat:@"%@ - %@", array[0], isNam ? @"Nam Mạng" : @"Nữ Mạng"];
    
    self.detalsList = [self.storyboard instantiateViewControllerWithIdentifier:@"detailListTuViVC"];
    self.detalsList.stringTitle = title;
    self.detalsList.stringDetail = array[3];
    self.detalsList.cID = 1123;
    [self.navigationController pushViewController:self.detalsList animated:NO];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
