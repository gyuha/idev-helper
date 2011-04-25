//
//  coverFlowViewController.h
//  coverFlow
//
//  Created by Gyuha Shin on 11. 4. 18..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoverFlowView.h"
@interface coverFlowViewController : UIViewController <CoverFlowViewDelegate>{
    CoverFlowView *coverFlow;
    NSMutableArray  *coverImages;
}

@end
