//
//  CustomTableViewCell.m
//  L'eko des garrigues
//
//  Created by Boris WEARCRAFT on 08/05/2016.
//  Copyright © 2016 Wearcraft. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

@synthesize trackartist;
@synthesize trackname;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
