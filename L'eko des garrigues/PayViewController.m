//
//  PayViewController.m
//  L'eko des garrigues
//
//  Created by boris on 03/07/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import "PayViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

// Set the environment:
// - For live charges, use PayPalEnvironmentProduction (default).
// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
// - For testing, use PayPalEnvironmentNoNetwork.
#define kPayPalEnvironment PayPalEnvironmentProduction

@interface PayViewController ()



@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation PayViewController


#pragma mark - Loader Action
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
    }
	
	
    return self;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor blackColor];
	
	//[PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AXb2QhDzoJUW1iD5-DOBdNWhkqF66umB4B1tgBoe-rGbLcQhL2RMtONOFh0h",  PayPalEnvironmentSandbox : @"AT5MvxCNcmtn0OKbEPtVZHLwLn598q_RFK5YhheB8nS70RT-c1liN-uJJ83e"}];

	
	// Set up payPalConfig
	//_payPalConfig = [[PayPalConfiguration alloc] init];
	//_payPalConfig.acceptCreditCards = YES;
	//_payPalConfig.languageOrLocale = @"fr";
	//_payPalConfig.merchantName = @"Eko des garrigues";
	//_payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
	//_payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
	
	// Setting the languageOrLocale property is optional.
	//
	// If you do not set languageOrLocale, then the PayPalPaymentViewController will present
	// its user interface according to the device's current language setting.
	//
	// Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
	// locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
	// to use that language/locale.
	//
	// For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
	
	//_payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
	
	// Do any additional setup after loading the view, typically from a nib.

	
	// use default environment, should be Production in real life
	//self.environment = kPayPalEnvironment;
	
	//NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
	//NSLog(@"Environment: %@", kPayPalEnvironment);

	//self.amountDonation.delegate = self;
	
	
	
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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	// Preconnect to PayPal early
	//[PayPalMobile preconnectWithEnvironment:self.environment];
}

- (void)viewDidDisappear:(BOOL)animated {
	
}
- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - XIB Action

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	//[textField resignFirstResponder];
	//[self payToPaypal];
	return YES;
}

- (IBAction)pay {
	NSString* launchUrl = @"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=D37GU49GP84YL";
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];

	
	//[self.view endEditing:YES];
	//[self payToPaypal];
}





#pragma mark - Receive Single Payment
/*
- (void) payToPaypal {
	// Remove our last completed payment, just for demo purposes.
	self.resultText = nil;
	
	// Note: For purposes of illustration, this example shows a payment that includes
	//       both payment details (subtotal, shipping, tax) and multiple items.
	//       You would only specify these if appropriate to your situation.
	//       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
	//       and simply set payment.amount to your total charge.
	
	// Optional: include multiple items
	NSNumber *amount = [[NSNumberFormatter alloc]numberFromString:_amountDonation.text];
	NSDecimalNumber *dAmount = [NSDecimalNumber decimalNumberWithDecimal:[amount decimalValue]];
	NSDecimalNumber *zero = [NSDecimalNumber decimalNumberWithString:@"0"];
	
	UIAlertView *alert = [[UIAlertView alloc]
        initWithTitle:@"Vous devez entrer un montant valide" message:nil delegate:nil
        cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	
	
	if([dAmount isEqual:zero]) {
		[alert show];
		return;
	}
	
	PayPalItem *item1 = [PayPalItem itemWithName:@"Donation"
									withQuantity:1
									   withPrice:dAmount
									withCurrency:@"EUR"
										 withSku:@"DONEKO"];
	NSArray *items =  [NSArray arrayWithObject:item1];
	NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
	
	// Optional: include payment details
	NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0"];
	NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0"];
	PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
																			   withShipping:shipping
																					withTax:tax];
	
	NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
	
	PayPalPayment *payment = [[PayPalPayment alloc] init];
	payment.amount = total;
	payment.currencyCode = @"EUR";
	payment.shortDescription = @"Eko des garrigues";
	payment.items = items;  // if not including multiple items, then leave payment.items as nil
	payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
	
	if (!payment.processable) {
		// This particular payment will always be processable. If, for
		// example, the amount was negative or the shortDescription was
		// empty, this payment wouldn't be processable, and you'd want
		// to handle that here.
	}
	
	// Update payPalConfig re accepting credit cards.
	self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
	
	PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
																								configuration:self.payPalConfig
																									 delegate:self];
	[self presentViewController:paymentViewController animated:YES completion:nil];
}


#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
	NSLog(@"PayPal Payment Success!");
	self.resultText = [completedPayment description];
	[self showSuccess];
	
	[self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
	NSLog(@"PayPal Payment Canceled");
	self.resultText = nil;
	self.successView.hidden = YES;
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
	// TODO: Send completedPayment.confirmation to server
	NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}


#pragma mark - Authorize Future Payments

- (IBAction)getUserAuthorization:(id)sender {
	
	PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
	[self presentViewController:futurePaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalFuturePaymentDelegate methods

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
	NSLog(@"PayPal Future Payment Authorization Success!");
	self.resultText = futurePaymentAuthorization[@"code"];
	[self showSuccess];
	
	[self sendAuthorizationToServer:futurePaymentAuthorization];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
	NSLog(@"PayPal Future Payment Authorization Canceled");
	self.successView.hidden = YES;
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendAuthorizationToServer:(NSDictionary *)authorization {
	// TODO: Send authorization to server
	NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}


#pragma mark - Helpers

- (void)showSuccess {
	self.amountView.hidden = YES;
	self.successView.hidden = NO;
	
	//self.successView.alpha = 1.0f;
	//[UIView beginAnimations:nil context:NULL];
	//[UIView setAnimationDuration:2.0];
	//[UIView setAnimationDelay:7.0];
	//self.successView.alpha = 0.0f;
	//[UIView commitAnimations];
}
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
