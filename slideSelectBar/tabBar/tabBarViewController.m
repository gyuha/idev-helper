//
//  tabBarViewController.m
//  tabBar
//
//  Created by Gyuha Shin on 11. 5. 2..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "tabBarViewController.h"


@implementation tabBarViewController

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    barImages = [[NSArray arrayWithObjects:
                 [UIImage imageNamed:@"selectorButton0.png"],
                 [UIImage imageNamed:@"selectorButton1.png"], nil] retain];
    
    barTitles = [[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", nil] retain];
    
    CustomSelectorBar *selectBar = [[CustomSelectorBar alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f,  110.0f)];
    selectBar.bgColor = [UIColor grayColor];
    selectBar.delegate = self;
    selectBar.buttonSize = CGSizeMake(30, 48);
    selectBar.leftCapWidth = 12;
    selectBar.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0];
    [selectBar reloadData];
    [self.view addSubview:selectBar];
    
	screenLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 200.0f, 300, 20.0f)];
    [self.view addSubview:screenLabel];

}

- (void)viewDidUnload
{
    [barImages release];
    [barTitles release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Custom selector bar
- (NSArray*) CustomSelectorBarTextItems:(CustomSelectorBar*)customSelectorBar
{
    return barTitles;
}

- (void) CustomSelectorBar:(CustomSelectorBar*)customSelectorBar selectedIndex:(NSInteger)index
{
    screenLabel.text = [NSString stringWithFormat:@"click : %d", index];    
    NSLog(@"Select Button : %d", index);
}

- (UIImage*) CustomSelectorBar:(CustomSelectorBar*)customSelectorBar buttonImages:(Boolean)select
{
    return [barImages objectAtIndex:select];
}

@end
