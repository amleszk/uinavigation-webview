
#import "SimpleWebViewController.h"

@interface SimpleWebViewController ()
@property (retain) UIWebView* webView;
@property (retain) NSURL* url;
@property (retain) SimpleWebViewToolBar* toolBar;
@end

@implementation SimpleWebViewController
@synthesize webView,url,toolBar;

-(id) initWithUrl:(NSURL*)aURL
{
	self = [super initWithNibName:nil bundle:nil];
	if (!self) {
		return nil;
	}
	self.url = aURL;
	return self;
}

-(void) presentModal
{
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:self] autorelease];
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] 
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                    target:self
                                    action:@selector(done)] autorelease];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
    navController.navigationBar.barStyle = UIBarStyleBlack;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentModalViewController:navController animated:TRUE];
}

-(void) done
{
    self.webView.delegate = nil;
	[[UIApplication sharedApplication].keyWindow.rootViewController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews
{
    if(self.view.superview)
    {    
        static CGFloat toolBarHeight = 44.;
        CGRect frame = self.view.superview.frame;
        frame.size.height += frame.origin.y;
        frame.origin.y  = 0.;
        frame.size.height -= toolBarHeight;
        if([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleBlackTranslucent)
            frame.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height;
        self.view.frame = frame;
        self.webView.frame = CGRectMake(0,0.,frame.size.width,frame.size.height-toolBarHeight);
        self.toolBar.frame = CGRectMake(0,frame.size.height-toolBarHeight,frame.size.width,toolBarHeight);
    }
}

- (void)viewDidLoad
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	self.webView.delegate = self;
	[self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
	self.toolBar = [[SimpleWebViewToolBar alloc] initWithFrame:CGRectZero webView:self.webView];
	
    [self.view addSubview:self.webView];
    [self.view addSubview:self.toolBar];
}

- (void)viewDidUnload {
    self.webView.delegate = nil;
	self.webView = nil;
    self.toolBar = nil;
	self.url = nil;
    [super viewDidUnload];
}


#pragma mark Webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webViewParam
{
	[self.toolBar setLoadingRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webViewParam
{
	self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	[self.toolBar setIdle];
}

- (void)webView:(UIWebView *)webViewParam didFailLoadWithError:(NSError *)error
{
	[self.toolBar setIdle];
}

@end
