

#import "SimpleWebViewToolBar.h"

@interface SimpleWebViewToolBar () <UIActionSheetDelegate>
@property (retain) UIBarButtonItem* itemRefesh;
@property (retain) UIBarButtonItem* itemBack;
@property (retain) UIBarButtonItem* itemForward;
@property (retain) UIBarButtonItem* itemAction;
@property (assign) UIWebView* webView;
@property (retain) UIBarButtonItem* spacer1;
@property (retain) UIBarButtonItem* spacer2;

-(void) setLandscapeItems;
-(void) setPortraitItems;
-(void) refreshToolBarButtons;

@end

@implementation SimpleWebViewToolBar
@synthesize itemAction,itemBack,itemRefesh,itemForward,spacer1,spacer2,webView;

- (id)initWithFrame:(CGRect)frame webView:(UIWebView*)webViewParam
{
    self = [super initWithFrame:frame];
    if (self) {		

		self.itemBack = [[[UIBarButtonItem alloc] 
					initWithImage:[UIImage imageNamed:@"back.png"]
					style:UIBarButtonItemStylePlain
					target:self 
					action:@selector(back)] autorelease];

		self.itemForward = [[[UIBarButtonItem alloc] 
					   initWithImage:[UIImage imageNamed:@"forward.png"]
					   style:UIBarButtonItemStylePlain
					   target:self 
					   action:@selector(forward)] autorelease];

		self.itemAction = [[[UIBarButtonItem alloc] 
									   initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
									   target:self 
									   action:@selector(action)] autorelease];
		
		[self setPortraitItems];
		self.barStyle = UIBarStyleBlack;
		self.webView = webViewParam;
    }
    return self;
}

- (void)dealloc {
    itemAction = nil,itemBack = nil,itemRefesh = nil,
    itemForward = nil,spacer1 = nil,spacer2 = nil,webView = nil;
    [super dealloc];
}

-(UIBarButtonItem*) spacerWithWidth:(CGFloat)w
{
	UIBarButtonItem* sp = [[[UIBarButtonItem alloc] 
                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
                           target:nil action:nil] autorelease];
	sp.width = w;
	return sp;
}

-(void) refreshToolBarButtons
{
	self.itemForward.enabled = webView.canGoForward;
	self.itemBack.enabled = webView.canGoBack;
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
	self.spacer1 = [self spacerWithWidth:10];
	self.spacer2 = [self spacerWithWidth:52];
	[self refreshToolBarItems];
}

-(void) setLandscapeItems
{
	self.spacer1 = [self spacerWithWidth:20];
	self.spacer2 = [self spacerWithWidth:104];
	[self refreshToolBarItems];
}

-(void) setLoadingRequest
{	
	UIActivityIndicatorView* activityInd = 
    [[[UIActivityIndicatorView alloc] 
      initWithFrame:CGRectMake(0, 0, 18, 18)] autorelease];
	activityInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	[activityInd startAnimating];
	self.itemRefesh = [[[UIBarButtonItem alloc] 
                        initWithCustomView:activityInd] autorelease];
	
	[self refreshToolBarItems];
}

-(void) setIdle
{
	self.itemRefesh = [[[UIBarButtonItem alloc] 
                       initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                       target:self
                       action:@selector(refresh)] autorelease];
	[self refreshToolBarItems];
}

-(void) forward
{
	[self.webView goForward];
	[self refreshToolBarButtons];
}

-(void) back
{
	[self.webView goBack];
	[self refreshToolBarButtons];
}

-(void) refresh {
	[self.webView reload];
}

-(void) action {
	UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:[[self.webView.request URL] absoluteString]
															 delegate:self 
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"Open in Safari",nil];
	[actionSheet showInView:self.superview];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:{
			[[UIApplication sharedApplication] openURL:[self.webView.request URL]];
			break;
		}
	}
}


@end
