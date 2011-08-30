

@interface SimpleWebViewToolBar : UIToolbar <UIActionSheetDelegate> {
	UIBarButtonItem* itemRefesh;
	UIBarButtonItem* itemBack;
	UIBarButtonItem* itemForward;
	UIBarButtonItem* itemAction;
	UIWebView* webView;
	
	UIBarButtonItem* spacer1;
	UIBarButtonItem* spacer2;
}

- (id)initWithFrame:(CGRect)frame webView:(UIWebView*)webView;
-(void) setLoadingRequest;
-(void) setIdle;

-(void) setLandscapeItems;
-(void) setPortraitItems;
-(void) refreshToolBarButtons;

@end
