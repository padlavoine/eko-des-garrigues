//
//  HistoryTracks.h
//  L'eko des garrigues
//
//  Created by Boris WEARCRAFT on 04/05/2016.
//  Copyright © 2016 Wearcraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DataController.h"
#import "PLAYLIST.h"
#import "CustomTableViewCell.h"

@interface HistoryTracksTableViewController : UITableViewController {
    DataController *dataController;
    NSManagedObjectContext *moc;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultController;

@end
