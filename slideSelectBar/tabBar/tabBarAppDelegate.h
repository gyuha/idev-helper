//
//  tabBarAppDelegate.h
//  tabBar
//
//  Created by Gyuha Shin on 11. 5. 2..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class tabBarViewController;

@interface tabBarAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet tabBarViewController *viewController;

@end
