//
//  PLAYLIST.h
//  L'eko des garrigues
//
//  Created by Boris WEARCRAFT on 03/05/2016.
//  Copyright © 2016 Wearcraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLAYLIST : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
@property (nonatomic, strong) NSString *trackname;
@property (nonatomic, strong) NSString *trackartist;
@property (nonatomic, strong) NSDate *date;

-(void)save;

@end

NS_ASSUME_NONNULL_END

#import "PLAYLIST+CoreDataProperties.h"
