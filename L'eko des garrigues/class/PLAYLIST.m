//
//  PLAYLIST.m
//  L'eko des garrigues
//
//  Created by Boris WEARCRAFT on 03/05/2016.
//  Copyright © 2016 Wearcraft. All rights reserved.
//

#import "PLAYLIST.h"

@implementation PLAYLIST

// Insert code here to add functionality to your managed object subclass
@dynamic trackartist;
@dynamic trackname;
@dynamic date;

-(void)save {
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO) {
        NSLog(@"Error Saving context");
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    } else {
        NSLog(@"Success Saving context");
    }
}
@end
