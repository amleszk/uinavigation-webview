
#import "SimpleWebViewToolBar.h"

@interface SimpleWebViewController : UIViewController<UIWebViewDelegate> 

-(id) initWithUrl:(NSURL*)url_;
-(void) presentModal;

@end
