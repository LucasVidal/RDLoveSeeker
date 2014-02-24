//
//  RDLoveSeeker.h
//  RDLoveSeeker
//
//  Created by Lucas Vidal on 2/17/14.
//  Copyright (c) 2014 Restorando. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDLoveSeeker : NSObject

//Initialization

+ (void) setDebug: (BOOL) configDebug;
+ (void) setDaysToRequestRating: (NSInteger) configDays;
+ (void) setEventsToRequestRating: (NSInteger) configEvents;
+ (void) setShouldRequestOnNewVersion: (BOOL) configShouldRequestOnNewVersion;
+ (void) setAppStoreID: (NSInteger) configAppStoreID;
+ (void) setFeedbackEmailAddress: (NSString *) configFeedbackEmailAddress;

//Control
+ (void) logSignificantEvent;
+ (void) verifyIfNeedsToBeShown;

//Internal

+ (NSInteger) appStoreID;
+ (NSString *) feedbackEmailAddress;
@end
