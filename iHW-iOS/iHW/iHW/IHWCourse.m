//
//  IHWCourse.m
//  iHW
//
//  Created by Jonathan Burns on 7/10/13.
//  Copyright (c) 2013 Jonathan Burns. All rights reserved.
//

#import "IHWCourse.h"
#import "IHWConstants.h"

@implementation IHWCourse

- (id)initWithName:(NSString *)n period:(int)p term:(int)t meetings:(NSArray *)m
{
    self = [super init];
    if (self) {
        self.name = n;
        self.period = p;
        self.term = t;
        self.meetings = [NSArray arrayWithArray:m];
    }
    return self;
}

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.period = [[dictionary objectForKey:@"period"] intValue];
        self.term = [[dictionary objectForKey:@"term"] intValue];
        self.meetings = [dictionary objectForKey:@"meetings"];
    }
    return self;
}

- (NSDictionary *)saveCourse {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.name forKey:@"name"];
    [dict setObject:[NSNumber numberWithInt:self.period] forKey:@"period"];
    [dict setObject:[NSNumber numberWithInt:self.term] forKey:@"term"];
    [dict setObject:self.meetings forKey:@"meetings"];
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (int)totalMeetings {
    //Count this course's meetings
    int sum = 0;
    for (int index = 0; index <self.meetings.count; index++) {
        if ([[self.meetings objectAtIndex:index] intValue] == MEETING_SINGLE_PERIOD) {
            sum++;
        } else if ([[self.meetings objectAtIndex:index] intValue] == MEETING_DOUBLE_AFTER || [[self.meetings objectAtIndex:index] intValue] == MEETING_DOUBLE_BEFORE) {
            sum+=2;
        }
    }
    return sum;
}

- (int)meetingOn:(int)dayNum {
    return [[self.meetings objectAtIndex:dayNum-1] intValue];
}

@end
