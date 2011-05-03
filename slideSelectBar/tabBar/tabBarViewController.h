//
//  tabBarViewController.h
//  tabBar
//
//  Created by Gyuha Shin on 11. 5. 2..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSelectorBar.h"

@interface tabBarViewController : UIViewController <CustomSelectorBarDelegate>{
    NSArray *barImages;
    NSArray *barTitles;
   	UILabel *screenLabel;
}

@end
