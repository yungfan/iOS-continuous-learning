//
//  AppDelegate.m
//  objc.io example project (issue #1)
//

#import "AppDelegate.h"
#import "PhotosViewController.h"



@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
 
    PhotosViewController *photosViewController = [[PhotosViewController alloc] initWithNibName:@"PhotosViewController"
                                                                                              bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:photosViewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
