

@interface SimpleWebViewToolBar : UIToolbar

- (id)initWithFrame:(CGRect)frame webView:(UIWebView*)webView;

-(void) setLoadingRequest;
-(void) setIdle;

@end
