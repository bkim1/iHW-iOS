//
//  IHWPeriod.m
//  iHW
//
//  Created by Jonathan Burns on 7/10/13.
//  Copyright (c) 2013 Jonathan Burns. All rights reserved.
//

#import "IHWPeriod.h"
#import "IHWDate.h"
#import "IHWCurriculum.h"

@implementation IHWPeriod

- (id)initWithName:(NSString *)name date:(IHWDate *)date start:(IHWTime *)start end:(IHWTime *)end number:(int)periodNum index:(int)periodIndex isFreePeriod:(BOOL)isFreePeriod
{
    self = [super init];
    if (self) {
        self.name = name;
        self.date = date;
        self.startTime = start;
        self.endTime = end;
        self.isFreePeriod = isFreePeriod;
        self.periodNum = periodNum;
        self.index = periodIndex;
        [self loadNotesFromCurriculum];
    }
    return self;
}

- (id)initWithJSONDictionary:(NSDictionary *)dictionary atIndex:(int)periodIndex
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.date = [[IHWDate alloc] initFromString:[dictionary objectForKey:@"date"]];
        self.startTime = [[IHWTime alloc] initFromString:[dictionary objectForKey:@"startTime"]];
        self.endTime = [[IHWTime alloc] initFromString:[dictionary objectForKey:@"endTime"]];
        self.isFreePeriod = [[dictionary objectForKey:@"isFreePeriod"] boolValue];
        self.periodNum = [[dictionary objectForKey:@"periodNum"] intValue];
        self.index = periodIndex;
        [self loadNotesFromCurriculum];
    }
    return self;
}

- (void)loadNotesFromCurriculum {
    //NSLog(@"Loading notes from curriculum on date: %@ index: %d", self.date.description, self.index);
    self.notes = [[[IHWCurriculum currentCurriculum] notesOnDate:self.date period:self.index] mutableCopy];
}

- (void)saveNotes {
    [[IHWCurriculum currentCurriculum] setNotes:self.notes onDate:self.date period:self.index];
}

- (NSDictionary *)savePeriod {
    //Notes DO NOT SAVE when the period is saved! Must save them separately!
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.name forKey:@"name"];
    [dict setObject:self.date.description forKey:@"date"];
    [dict setObject:self.startTime.description forKey:@"startTime"];
    [dict setObject:self.endTime.description forKey:@"endTime"];
    [dict setObject:[NSNumber numberWithInt:self.periodNum] forKey:@"periodNum"];
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
