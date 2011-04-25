//
//  slideMenuViewController.h
//  slideMenu
//
//  Created by Gyuha Shin on 11. 4. 12..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuView.h"

@interface slideMenuViewController : UIViewController <SlideMenuViewDelegate>{
    NSMutableArray *thumbnails;    
   	UILabel *screenLabel;
}

@end
