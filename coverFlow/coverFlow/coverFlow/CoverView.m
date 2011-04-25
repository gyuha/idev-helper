//
//  CoverView.m
//  coverFlow
//
//  Created by Gyuha Shin on 11. 4. 19..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "CoverView.h"


@implementation CoverView

@synthesize 
imageView = _imageView,
number = _number,
horizontalPosition = _horizontalPosition,
verticalPosition = _verticalPosition;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = NULL;
        _verticalPosition = 0.0f;
        _horizontalPosition = 0.0f;
        
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.opaque = YES;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image originalImageHeight:(CGFloat)imageHeight reflectionFraction:(CGFloat)reflectionFraction
{
    [_imageView setImage:image];
    _verticalPosition = imageHeight * reflectionFraction / 2;
    _originalImageHeight = imageHeight;
    self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
}

- (void)setNumber:(NSInteger)number coverSpacing:(CGFloat)coverSpacing
{
    _horizontalPosition = coverSpacing * number;
    _number = number;
}


- (CGSize)calculateNewSize:(CGSize)baseImageSize boundingBox:(CGSize)boundingBox
{
	CGFloat boundingRatio = boundingBox.width / boundingBox.height;
	CGFloat originalImageRatio = baseImageSize.width / baseImageSize.height;
	
	CGFloat newWidth;
	CGFloat newHeight;
	if (originalImageRatio > boundingRatio) {
		newWidth = boundingBox.width;
		newHeight = boundingBox.width * baseImageSize.height / baseImageSize.width;
	} else {
		newHeight = boundingBox.height;
		newWidth = boundingBox.height * baseImageSize.width / baseImageSize.height;
	}
	
	return CGSizeMake(newWidth, newHeight);
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_imageView setFrame:frame];
}

- (void)dealloc
{
    [_imageView release];
    [super dealloc];
}

@end
