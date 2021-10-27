//
//  HistoryTracks.m
//  L'eko des garrigues
//
//  Created by Boris WEARCRAFT on 04/05/2016.
//  Copyright © 2016 Wearcraft. All rights reserved.
//

#import "HistoryTracksTableViewController.h"

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface HistoryTracksTableViewController ()

@end

@implementation HistoryTracksTableViewController

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)emptyPlaylist {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"PLAYLIST" inManagedObjectContext:moc]];
    [request setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *lists = [moc executeFetchRequest:request error:&error];

    //error handling goes here
    for (NSManagedObject *list in lists) {
        [moc deleteObject:list];
    }
    NSError *saveError = nil;
    //[moc save:&saveError];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PLAYLIST"];
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:FALSE];
    NSArray *sortDescriptors = @[dateSort];

    [request setSortDescriptors:sortDescriptors];
    [request setReturnsObjectsAsFaults:NO];
    [self setFetchedResultController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchedResultController] setDelegate:self];
    
    NSError *error = nil;
    if(![[self fetchedResultController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    dataController = [[DataController alloc] init];
    moc = dataController.managedObjectContext;
    NSLog(@"%@",moc);
    
    [self initializeFetchedResultsController];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Retour" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Vider" style:UIBarButtonItemStylePlain target:self action:@selector(emptyPlaylist)];
    
    if( IPAD ) {
        UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"Fermer"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(close)];
        [self.navigationItem setRightBarButtonItem:closeBtn];
        
        [self.navigationController.navigationBar.layer setBorderWidth:1.0];// Just to make sure its working
        [self.navigationController.navigationBar.layer setBorderColor:[[UIColor colorWithRed:0.99 green:0.91 blue:0.27 alpha:1.0] CGColor]];
        
        self.view.layer.borderColor = [[UIColor colorWithRed:0.99 green:0.91 blue:0.27 alpha:1.0] CGColor];
        self.view.layer.borderWidth = 1.0;
    }
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.99 green:0.91 blue:0.27 alpha:1.0]];
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)configureCell:(CustomTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    id object = [[self fetchedResultController] objectAtIndexPath:indexPath];
    
    PLAYLIST *playlist = object;
    cell.trackname.text = playlist.trackname;
    cell.trackartist.text = playlist.trackartist;
    
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSString *date = [timeFormatter stringFromDate:playlist.date ];
    if(date == nil) {
        cell.date.text = @"";
    } else {
        NSString *stringDate = [NSString stringWithFormat:@"%@ GMT",date];
        cell.date.text = stringDate;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[[self fetchedResultController] sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultController] sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cellPlaylist";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}



@end
