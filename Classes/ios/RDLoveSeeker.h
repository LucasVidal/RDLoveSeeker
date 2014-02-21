//
//  RDLoveSeeker.h
//  RDLoveSeeker
//
//  Created by Lucas Vidal on 2/17/14.
//  Copyright (c) 2014 Restorando. All rights reserved.
//

#import <Foundation/Foundation.h>

//TODO: remove this defines and use config methods below.
#define LSDEBUG
#define DAYS_TO_REQUEST_RATING 14
#define EVENTS_TO_REQUEST_RATING 3
#define SHOULD_REQUEST_ON_NEW_VERSION YES
#define APPSTORE_APP_ID 529290320
#define FEEDBACK_EMAIL_ADDRESS @"feedback@restorando.com"

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

@end
