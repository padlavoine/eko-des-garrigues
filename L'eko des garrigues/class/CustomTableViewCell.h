//
//  CustomTableViewCell.h
//  L'eko des garrigues
//
//  Created by Boris WEARCRAFT on 08/05/2016.
//  Copyright © 2016 Wearcraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *trackartist;
@property (weak, nonatomic) IBOutlet UILabel *trackname;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
