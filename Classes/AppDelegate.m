
#import "SimpleWebViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> 

@property (nonatomic, retain) UIWindow *window;

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:nil];
    
    NSURL* exampleURL = [NSURL URLWithString:@"http://www.twitter.com"];
	[[[SimpleWebViewController alloc] initWithUrl:exampleURL] presentModal];

    
    return YES;
}

-(void) dealloc
{
	self.window = nil;
	[super dealloc];
}


@end
