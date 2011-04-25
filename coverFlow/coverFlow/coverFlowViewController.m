//
//  coverFlowViewController.m
//  coverFlow
//
//  Created by Gyuha Shin on 11. 4. 18..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "coverFlowViewController.h"

@implementation coverFlowViewController

- (void)dealloc
{
    [coverImages release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(UIImage *)addText:(UIImage *)img text:(NSString *)text1{
    int w = img.size.width;
    int h = img.size.height; 
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1);
    
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Arial", 30, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 255, 255, 1);
    CGSize stringSize = [text1 sizeWithFont:[UIFont fontWithName:@"Arial" size:30]];
    CGContextShowTextAtPoint(context, (w-stringSize.width)/2, (h-stringSize.height)/2, text, strlen(text));
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:imageMasked];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    coverImages = [[NSMutableArray new] retain];

    for (int i=0; i<30; i++) {
        UIImage *image = [UIImage imageNamed:@"cover.jpg"];
        image = [self addText:image text:[NSString stringWithFormat:@"%d", i]];
        [coverImages addObject:image];
    }

    coverFlow = [[CoverFlowView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    coverFlow.delegate = self;
    coverFlow.coverImageType = COVER_IMAGE_TYPE_IMAGE;
    coverFlow.coverSideAngle = .75;
    coverFlow.coverSpacing = 40;
    coverFlow.coverBufferCount = 6;
    coverFlow.coverReflectionFraction = 0.75;
    coverFlow.coverSizeZPosition = -80;
    coverFlow.coverCenterOffset = 70;
    coverFlow.backgroundColor = [UIColor whiteColor];
    
    [coverFlow reloadData];
    [self.view addSubview:coverFlow];
    [coverFlow setSelectedCover:15 animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSArray*) coverFlowViewImages:(CoverFlowView*)coverFlowView
{
    return coverImages;
}
- (void) coverFlowViewSelectedImage:(CoverFlowView*)coverFlowView index:(NSInteger)index
{
    NSLog(@"Selected Cover : %d", index);
}
@end
