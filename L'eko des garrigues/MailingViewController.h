//
//  MailingViewController.h
//  L'eko des garrigues
//
//  Created by boris on 03/07/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailingViewController : UIViewController <NSURLConnectionDelegate, UITextFieldDelegate> {
	NSDictionary *_responseData;
}

@property (weak, nonatomic) IBOutlet UITextView *mailingText;
@property (weak, nonatomic) IBOutlet UITextField *emailValue;
@property (weak, nonatomic) IBOutlet UIButton *sendFormBtn;

@property (weak, nonatomic) IBOutlet UITextView *responsePhpMail;

- (IBAction)sendForm:(id)sender;

@end
