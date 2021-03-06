//
//  IHWDate.h
//  iHW
//
//  Created by Jonathan Burns on 7/11/13.
//  Copyright (c) 2013 Jonathan Burns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHWTime.h"
typedef NSDate IHWDate;

@interface NSDate (IHW)

+ (IHWDate *)today;

- (id)initToday;
- (id)initWithMonth:(int)m day:(int)d year:(int)y;
- (id)initFromString:(NSString *)string;

-(int)month;
-(int)day;
-(int)year;

- (BOOL)isMonday;
- (BOOL)isWeekend;
- (NSDate *)dateByAddingDays:(int)days;
- (NSDate *)dateOfNextSunday;
- (NSDate *)dateOfPreviousSunday;
- (NSString *)description;
- (int)daysUntilDate:(NSDate *)other;
- (NSString *)dayOfWeek:(BOOL)shortVersion;
- (BOOL)isEqualToDate:(NSDate *)otherDate;
- (NSDate *)NSDateWithTime:(IHWTime *)time;

+ (NSComparator)comparator;

@end