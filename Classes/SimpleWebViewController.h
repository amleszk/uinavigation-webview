
#import "SimpleWebViewToolBar.h"

@interface SimpleWebViewController : UIViewController<UIWebViewDelegate> {
	UIWebView* webView;
	NSURL* url;
	SimpleWebViewToolBar* toolBar;
}

-(id) initWithUrl:(NSURL*)url_;

@end
