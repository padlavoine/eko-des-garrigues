//
//  AboutViewController.m
//  L'eko des garrigues
//
//  Created by boris on 03/07/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import "AboutViewController.h"

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface AboutViewController ()

@end

@implementation AboutViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)close
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad
{
	
	
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor blackColor];
	
	
	
	_aboutText.editable = false;
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Retour" style:UIBarButtonItemStylePlain target:nil action:nil];
	
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
	if(!IPAD ) {
		[self.navigationController setNavigationBarHidden:YES animated:animated];
	}
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (IBAction)makeDons:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.paypal.com/fr/cgi-bin/webscr?cmd=_flow&SESSION=0xcLh1qdki2VGSBy2qhLqPb25rfk5EZVWoIPERG_9HZVasI7xfz3gH87Pne&dispatch=50a222a57771920b6a3d7b606239e4d529b525e0b7e69bf0224adecfb0124e9b61f737ba21b08198a0586321b47f5ae7b54ee269d9200b8b"]];

}

@end
