//
//  slideMenuAppDelegate.h
//  slideMenu
//
//  Created by Gyuha Shin on 11. 4. 12..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class slideMenuViewController;

@interface slideMenuAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet slideMenuViewController *viewController;

@end
