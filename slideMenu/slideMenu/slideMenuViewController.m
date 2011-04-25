//
//  slideMenuViewController.m
//  slideMenu
//
//  Created by Gyuha Shin on 11. 4. 12..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "slideMenuViewController.h"
#import "SlideMenuView.h"

@implementation slideMenuViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    thumbnails = [[NSMutableArray new] retain];
    for (int i = 0; i < 10; i++) {
        [thumbnails addObject:[NSString stringWithFormat:@"%02d.jpg", i+1]];
    }

    SlideMenuView *slview = [[SlideMenuView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f,  110.0f)];
    slview.delegate = self;
    slview.backgroundColor = [UIColor redColor];
    slview.selectedColor = [UIColor blueColor];
    slview.borderDeep = 5.0f;
    slview.selectedItem = 2;
    slview.imageSize = CGSizeMake(60, 85);
    [slview reloadData];
    [self.view addSubview:slview];
    
	screenLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 200.0f, 300, 20.0f)];
    [self.view addSubview:screenLabel];
}

/**
 * 꼭 추가해 줘야 함
 */
- (NSArray*) slideMenuViewImages:(SlideMenuView*)slideMenuView
{
    return thumbnails;
}

- (void) slideMenuViewClick:(SlideMenuView*)slideMenuView selectIndex:(NSInteger)index;
{
    screenLabel.text = [NSString stringWithFormat:@"click : %d", index];
}
- (void) slideMenuClick:(id)sender
{
    screenLabel.text = [NSString stringWithFormat:@"click : %d", ((UIButton*)sender).tag];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
