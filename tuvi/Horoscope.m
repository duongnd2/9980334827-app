//
//  Horoscope.m
//  tuvi
//
//  Created by DuongND on 1/22/14.
//  Copyright (c) 2014 DuongNguyen. All rights reserved.
//

#import "Horoscope.h"

@implementation Horoscope

-(id) initWithSummary:(NSString*) summary
              andmood:(NSString*) mood
         andmood_star:(NSString*) mood_star
              andlove:(NSString*) love
         andlove_star:(NSString*) love_star
             andmoney:(NSString*) money
        andmoney_star:(NSString*) money_star
              andwork:(NSString*) work
         andwork_star:(NSString*) work_star
{
    if (self == [super init]) {
        self.summary = summary;
        self.mood = mood;
        self.mood_star = mood_star;
        self.love = love;
        self.love_star = love_star;
        self.money = money;
        self.money_star = money_star;
        self.work = work;
        self.work_star = work_star;
    }
    return  self;
}
@end
