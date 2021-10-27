//
//  ProgrammViewController.m
//  L'eko des garrigues
//
//  Created by boris on 11/06/2014.
//  Copyright (c) 2014 Wearcraft. All rights reserved.
//

#import "ProgrammViewController.h"

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
@interface ProgrammViewController ()

@end

@implementation ProgrammViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
    }
    return self;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor blackColor];
	
	weeklyProgram = true;
}

-(void)viewDidAppear:(BOOL)animated {
	webview = [[UIWebView alloc] initWithFrame:_contentView.bounds];
	webview.opaque = NO;
	webview.backgroundColor = [UIColor blackColor];
	webview.autoresizesSubviews = YES;
	webview.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	webview.delegate = self;
	
	
	
	[self loadProgramme];
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











- (void)webViewDidStartLoad:(UIWebView *)webView {
	spinner = [SpinnerView loadSpinnerIntoView:_contentView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[webview stringByEvaluatingJavaScriptFromString:@"document.body.style.textAlign = 'center';"];
    [webview stringByEvaluatingJavaScriptFromString:@"document.getElementById('page').style.textAlign = 'center';"];
    [webview stringByEvaluatingJavaScriptFromString:@"document.getElementById('page').style.width = '100%';"];
    [webview stringByEvaluatingJavaScriptFromString:@"document.getElementById('conteneur').style.width = '100%';"];
    [webview stringByEvaluatingJavaScriptFromString:@"document.body.style.background = '#000';"];
    [webview stringByEvaluatingJavaScriptFromString:@"document.body.style.color = '#fff';"];
    NSString *str = @" function f() {"
    @"var element = document.getElementById('entete');"
    @"element.parentNode.removeChild(element);"
    @"var element = document.getElementById('navigation');"
    @"element.parentNode.removeChild(element);"
    @"var element = document.getElementById('extra');"
    @"element.parentNode.removeChild(element);"
    @"var element = document.getElementById('pied');"
    @"element.parentNode.removeChild(element);"
    @"var element = document.getElementById('hierarchie');"
    @"element.parentNode.removeChild(element);"
    @"var element = document.getElementById('forum');"
    @"element.parentNode.removeChild(element);"
    
    
    @"var paras = document.getElementsByClassName('cartouche');"
    @"while(paras[0]) {"
    @"    paras[0].parentNode.removeChild(paras[0]);"
    @"}"
    @"}"
    @"f();";
    
    
    
    
    
    
    [webview stringByEvaluatingJavaScriptFromString:str];

	[spinner removeSpinner];
	
}


- (IBAction)switchWebView:(id)sender {
	if(weeklyProgram) {
		weeklyProgram = false;
		[self loadEmissions];
	} else {
		weeklyProgram = true;
		[self loadProgramme];
	}
}

- (IBAction)actionLoadEmission:(id)sender {
	weeklyProgram = false;
	[self loadEmissions];
}
- (IBAction)actionLoadProgramme:(id)sender {
	weeklyProgram = true;
	[self loadProgramme];
}


-(void)loadProgramme {
	
	requestObject = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ekodesgarrigues.com/actu/breve/cette-semaine-11"]];
	if(!IPAD) {
		[_linkSwitch setTitle:@"Programme" forState:UIControlStateNormal];
	}
	[webview loadRequest:requestObject];
    [_contentView addSubview:webview];
	
}
-(void)loadEmissions {
	requestObject = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ekodesgarrigues.com/Appli/detailsProgramme.php"]];
	if(!IPAD) {
		[_linkSwitch setTitle:@"Emissions" forState:UIControlStateNormal];
	}
	[webview loadRequest:requestObject];
	[_contentView addSubview:webview];
}


@end
