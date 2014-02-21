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
        
        if (SHOULD_REQUEST_ON_NEW_VERSION && ![[RDLoveSeekerStatusController currentBuildVersion] isEqualToString: [RDLoveSeekerStatusController lastVersionUsed]])
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
    if ([now timeIntervalSinceDate: installDate] > (DAYS_TO_REQUEST_RATING * 24 * 60 * 60))
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
    if (events >= EVENTS_TO_REQUEST_RATING) {
        RDLSLog(@"Events condition met.");
        [RDLoveSeekerStatusController requestUserRating];
        return;
    }
    else
    {
        RDLSLog(@"Did not meet events count condition. (%d < %d)", events, EVENTS_TO_REQUEST_RATING);
    }
}


@end
