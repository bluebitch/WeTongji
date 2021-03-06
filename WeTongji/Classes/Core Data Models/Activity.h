//
//  Activity.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Event.h"


@interface Activity : Event

@property (nonatomic, retain) NSString * activity_id;
@property (nonatomic, retain) NSString * avatar_link;
@property (nonatomic, retain) NSNumber * can_favorite;
@property (nonatomic, retain) NSNumber * can_like;
@property (nonatomic, retain) NSNumber * can_schedule;
@property (nonatomic, retain) NSNumber * channel_id;
@property (nonatomic, retain) NSDate * channel_update_date;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * favorite_count;
@property (nonatomic, retain) NSDate * favorite_update_date;
@property (nonatomic, retain) NSNumber * hidden;
@property (nonatomic, retain) NSNumber * image_count;
@property (nonatomic, retain) NSString * image_link;
@property (nonatomic, retain) NSNumber * like_count;
@property (nonatomic, retain) NSString * organizer;
@property (nonatomic, retain) NSNumber * schedule_count;
@property (nonatomic, retain) NSString * status;

@end
