
#import "SimpleWebViewController.h"

#define NAVIGATIONBAR_HEIGHT 44
#define TOOLBAR_HEIGHT 44
#define STATUSBAR_HEIGHT 20
#define IPHONE_HEIGHT 480
#define IPHONE_WIDTH 320

@implementation SimpleWebViewController

-(id) initWithUrl:(NSURL*)url_
{
	self = [super initWithNibName:nil bundle:nil];
	if (!self) {
		return nil;
	}
	url = [url_ copy];
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	float webViewHeight = IPHONE_HEIGHT-STATUSBAR_HEIGHT-NAVIGATIONBAR_HEIGHT-TOOLBAR_HEIGHT;	
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,IPHONE_WIDTH,webViewHeight)];
	webView.delegate = self;
	[self.view addSubview:webView];
	
	toolBar = [[SimpleWebViewToolBar alloc] initWithFrame:CGRectMake(0,webViewHeight,IPHONE_WIDTH,TOOLBAR_HEIGHT) 
												  webView:webView];
	[self.view addSubview:toolBar];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[webView release];
	[toolBar release];
}

- (void)viewDidAppear:(BOOL)animated
{
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webView loadRequest:requestObj];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
	   toInterfaceOrientation == UIInterfaceOrientationLandscapeRight )
	{	
		float webViewHeight = IPHONE_WIDTH-STATUSBAR_HEIGHT-NAVIGATIONBAR_HEIGHT-TOOLBAR_HEIGHT;
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:duration];
		webView.frame = CGRectMake(0,0,IPHONE_HEIGHT,webViewHeight);
		toolBar.frame = CGRectMake(0,webViewHeight,IPHONE_HEIGHT,TOOLBAR_HEIGHT);
		[toolBar setLandscapeItems];
		[UIView commitAnimations];
	}
	else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || 
			toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
	{
		float webViewHeight = IPHONE_HEIGHT-STATUSBAR_HEIGHT-NAVIGATIONBAR_HEIGHT-TOOLBAR_HEIGHT;
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:duration];
		webView.frame = CGRectMake(0,0,IPHONE_WIDTH,webViewHeight);
		toolBar.frame = CGRectMake(0,webViewHeight,IPHONE_WIDTH,TOOLBAR_HEIGHT);
		[toolBar setPortraitItems];
		[UIView commitAnimations];
	}
}

- (void)dealloc {
    [super dealloc];
	[url release];
}


#pragma mark Webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType
{
	return TRUE;
}


- (void)webViewDidStartLoad:(UIWebView *)webViewParam
{
	[toolBar setLoadingRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webViewParam
{
	self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	[toolBar setIdle];
}

- (void)webView:(UIWebView *)webViewParam didFailLoadWithError:(NSError *)error
{
	[toolBar setIdle];
}

@end
