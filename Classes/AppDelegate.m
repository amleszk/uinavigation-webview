
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	NSURL* exampleURL = [NSURL URLWithString:@"http://www.twitter.com"];
	simpleWebViewController = [[SimpleWebViewController alloc] initWithUrl:exampleURL];
	rootViewController = [[UINavigationController alloc] initWithRootViewController:simpleWebViewController];
	
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window addSubview:rootViewController.view];
    [window makeKeyAndVisible];
	
    return YES;
}

-(void) dealloc
{
	[window release];
	[rootViewController release];
	[simpleWebViewController release];
	[super dealloc];
}


@end
