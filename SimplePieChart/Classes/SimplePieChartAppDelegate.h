//
//  SimplePieChartAppDelegate.h
//  SimplePieChart
//
//  Created by Gyuha Shin on 10. 8. 5..
//  Copyright Dreamers Entertainment Co, Ltd. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimplePieChartViewController;

@interface SimplePieChartAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SimplePieChartViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SimplePieChartViewController *viewController;

@end

