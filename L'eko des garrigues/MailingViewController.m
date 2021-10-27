//
//  MailingViewController.m
//  L'eko des garrigues
//
//  Created by boris on 03/07/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import "MailingViewController.h"
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface MailingViewController ()

@end

@implementation MailingViewController



- (void)sendFormToUrl {
	// Create the request.
	NSString *mail = _emailValue.text;
	
	if([mail isEqual: @""]) {
		return;
	}
	
	NSString *url = [NSString stringWithFormat:@"https://url-to-send-subscribe/send.php?mail=%@", mail];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	// Create url connection and fire request
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
    }
    return self;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Retour" style:UIBarButtonItemStylePlain target:nil action:nil];
	
	self.emailValue.delegate = self;
	
	if( IPAD ) {
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


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	[self sendFormToUrl];
	return YES;
}


- (IBAction)sendForm:(id)sender {
	[self.view endEditing:YES];
	[self sendFormToUrl];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// A response has been received, this is where we initialize the instance var you created
	// so that we can append data to it in the didReceiveData method
	// Furthermore, this method is called each time there is a redirect so reinitializing it
	// also serves to clear it
	_responseData = [[NSDictionary alloc] init];
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// Append the new data to the instance variable you declared
	
	
	//NSLog(@"connectionDidFinishLoading");
	//NSLog(@"Succeeded! Received %d bytes of data",[data length]);
	//NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	//NSLog(@"%@", responseString);
	
	
	NSError *error = nil;
	_responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

	if([[_responseData valueForKeyPath:@"result"]  isEqual: @"SUCCESS"]) {
		[self.responsePhpMail setText:@"Votre demande d'inscription à la newsletter à bien été reçu."];
		[self.responsePhpMail setTextColor:[UIColor greenColor]];
	}else if([[_responseData valueForKeyPath:@"result"]  isEqual: @"ERRORMAIL"]) {
		[self.responsePhpMail setText:@"Vous devez entrer un email valide"];
		[self.responsePhpMail setTextColor:[UIColor redColor]];
	} else {
		[self.responsePhpMail setText:@"Une erreur est survenue, merci de renouveller votre demande ultérieurement."];
		[self.responsePhpMail setTextColor:[UIColor redColor]];
	}
	[self.responsePhpMail setTextAlignment:NSTextAlignmentCenter];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	// Return nil to indicate not necessary to store a cached response for this connection
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// The request is complete and data has been received
	// You can parse the stuff in your instance variable now
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// The request has failed for some reason!
	// Check the error var
}



@end
