//
//  coverFlowAppDelegate.h
//  coverFlow
//
//  Created by Gyuha Shin on 11. 4. 18..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class coverFlowViewController;

@interface coverFlowAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet coverFlowViewController *viewController;

@end
