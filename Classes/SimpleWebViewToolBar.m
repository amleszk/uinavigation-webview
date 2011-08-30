

#import "SimpleWebViewToolBar.h"

@implementation SimpleWebViewToolBar

-(UIBarButtonItem*) spacerWithWidth:(CGFloat)w
{
	UIBarButtonItem* sp = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
																		target:nil action:nil];
	sp.width = w;
	return sp;
}

-(void) refreshToolBarButtons
{
	itemForward.enabled = webView.canGoForward;
	itemBack.enabled = webView.canGoBack;
}

-(void) refreshToolBarItems
{
	[self setItems:[NSArray arrayWithObjects:
					spacer1,itemBack,spacer2,itemForward,spacer2,
					itemRefesh,spacer2,itemAction,nil] animated:FALSE];	
	[self refreshToolBarButtons];
}

-(void) setPortraitItems
{
	[spacer1 release];
	[spacer2 release];
	spacer1 = [self spacerWithWidth:10];
	spacer2 = [self spacerWithWidth:52];
	[self refreshToolBarItems];
}

-(void) setLandscapeItems
{
	[spacer1 release];
	[spacer2 release];
	spacer1 = [self spacerWithWidth:20];
	spacer2 = [self spacerWithWidth:104];
	[self refreshToolBarItems];
}


- (id)initWithFrame:(CGRect)frame webView:(UIWebView*)webViewParam
{
    
    self = [super initWithFrame:frame];
    if (self) {		

		itemBack = [[UIBarButtonItem alloc] 
					initWithImage:[UIImage imageNamed:@"back.png"]
					style:UIBarButtonItemStylePlain
					target:self 
					action:@selector(back)];

		itemForward = [[UIBarButtonItem alloc] 
					   initWithImage:[UIImage imageNamed:@"forward.png"]
					   style:UIBarButtonItemStylePlain
					   target:self 
					   action:@selector(forward)];

		itemAction = [[UIBarButtonItem alloc] 
									   initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
									   target:self 
									   action:@selector(action)];
		
		[self setPortraitItems];
		self.barStyle = UIBarStyleBlack;
		webView = [webViewParam retain];
		
    }
    return self;
}

-(void) setLoadingRequest
{	
	UIActivityIndicatorView* activityInd = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)] autorelease];
	activityInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	[activityInd startAnimating];
	itemRefesh = [[UIBarButtonItem alloc] 
				  initWithCustomView:activityInd];
	
	[self refreshToolBarItems];
}

-(void) setIdle
{
	[itemRefesh release];
	itemRefesh = [[UIBarButtonItem alloc] 
				  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
				  target:self
				  action:@selector(refresh)];
	[self refreshToolBarItems];
}

- (void)dealloc {
	[webView release];
	[spacer1 release];
	[spacer2 release];
    [super dealloc];
}

-(void) forward
{
	[webView goForward];
	[self refreshToolBarButtons];
}

-(void) back
{
	[webView goBack];
	[self refreshToolBarButtons];
}

-(void) refresh {
	[webView reload];
}

-(void) action {
	UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:[[webView.request URL] absoluteString]
															 delegate:self 
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"Open in Safari",nil];
	[actionSheet showInView:self.superview];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:{
			[[UIApplication sharedApplication] openURL:[webView.request URL]];
			break;
		}
	}
}


@end
