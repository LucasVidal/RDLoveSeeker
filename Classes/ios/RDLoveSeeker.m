//
//  RDLoveSeeker.m
//  RDLoveSeeker
//
//  Created by Lucas Vidal on 2/17/14.
//  Copyright (c) 2014 Restorando. All rights reserved.
//

#import "RDLoveSeeker.h"
#import "RDLoveSeekerWindow.h"
#import "RDLoveSeekerViewController.h"
#import "RDLoveSeekerStatusController.h"

static BOOL isDebug;
static NSInteger daysToRequestRating;
static NSInteger eventsToRequestRating;
static BOOL shouldRequestOnNewVersion;
static NSInteger appStoreID;
static NSString *feedbackEmailAddress;

@implementation RDLoveSeeker

+ (void) logSignificantEvent
{
    [RDLoveSeekerStatusController logSignificantEvent];
}

+ (void) verifyIfNeedsToBeShown
{
    if ([RDLoveSeekerStatusController hasBeenShown])
    {
        RDLSLog(@"Already shown!");
        
        if (shouldRequestOnNewVersion && ![[RDLoveSeekerStatusController currentBuildVersion] isEqualToString: [RDLoveSeekerStatusController lastVersionUsed]])
        {
            RDLSLog(@"Version changed from %@ to %@. Reseting counters.", [RDLoveSeekerStatusController lastVersionUsed], [RDLoveSeekerStatusController currentBuildVersion]);
            [RDLoveSeekerStatusController resetAllCounters];
        }
        else
        {
            return;
        }
    }
    
    NSDate *installDate = [RDLoveSeekerStatusController installDate];
    
    if (!installDate) [RDLoveSeekerStatusController setInstallDate];
    
    //Verifying for time frame
    NSDate *now = [NSDate date];
    if ([now timeIntervalSinceDate: installDate] > (daysToRequestRating * 24 * 60 * 60))
    {
        RDLSLog(@"Time frame condition met.");
        [RDLoveSeekerStatusController requestUserRating];
        return;
    }
    else
    {
        RDLSLog(@"Did not meet time condition. (installed on %@)", now);
    }
    
    //Verifying for events frame
    NSInteger events = [RDLoveSeekerStatusController significantEvents];
    if (events >= eventsToRequestRating) {
        RDLSLog(@"Events condition met.");
        [RDLoveSeekerStatusController requestUserRating];
        return;
    }
    else
    {
        RDLSLog(@"Did not meet events count condition. (%d < %d)", events, eventsToRequestRating);
    }
}

+ (NSInteger) appStoreID
{
    return appStoreID;
}

+ (NSString *) feedbackEmailAddress
{
    return feedbackEmailAddress;
}

+ (void) setDebug: (BOOL) configDebug {
    isDebug = configDebug;
}
+ (void) setDaysToRequestRating: (NSInteger) configDays {
    daysToRequestRating = configDays;
}

+ (void) setEventsToRequestRating: (NSInteger) configEvents {
    eventsToRequestRating = configEvents;
}
+ (void) setShouldRequestOnNewVersion: (BOOL) configShouldRequestOnNewVersion {
    shouldRequestOnNewVersion = configShouldRequestOnNewVersion;
}
+ (void) setAppStoreID: (NSInteger) configAppStoreID {
    appStoreID = configAppStoreID;
}
+ (void) setFeedbackEmailAddress: (NSString *) configFeedbackEmailAddress {
    feedbackEmailAddress = configFeedbackEmailAddress;
}

@end
