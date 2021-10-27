//
//  PLAYLIST+CoreDataProperties.h
//  L'eko des garrigues
//
//  Created by Boris WEARCRAFT on 03/05/2016.
//  Copyright © 2016 Wearcraft. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PLAYLIST.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLAYLIST (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *trackname;
@property (nullable, nonatomic, retain) NSString *trackartist;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END
