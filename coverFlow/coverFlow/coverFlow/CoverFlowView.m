//
//  CoverFlowView.m
//  coverFlow
//
//  Created by Gyuha Shin on 11. 4. 18..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "CoverFlowView.h"
#import "UIImage+Reflection.h"
#import "Macros.h"

#define DEFAULT_COVER_REFLECTION_FRACTION   0.85f
#define DEFAULT_COVER_SPACING               40
#define DEFAULT_COVER_CENTER_OFFSET         70
#define DEFAULT_COVER_SIDE_ANGLE            .79
#define DEFAULT_COVER_SIZE_ZPOSITION        -80
#define DEFAULT_COVER_BUFFER_COUNT          6

@interface CoverFlowView (private)
- (void)layoutCover:(CoverView *)aCover selectedCover:(int)selectedIndex animated:(Boolean)animated;
- (void)setBounds:(CGRect)newSize;
@end

@implementation CoverFlowView
@synthesize delegate;
@synthesize 
coverImageType = _coverImageType,
coverBufferCount = _coverBufferCount,
coverReflectionFraction = _coverReflectionFraction,
coverSpacing = _coverSpacing,
coverCenterOffset = _coverCenterOffset,
coverSideAngle = _coverSideAngle,
coverSizeZPosition = _coverSizeZPosition;

/**
 * 변형 설정
 */
- (void) setCoverTransform
{
	// 커버의 좌,우 변환 설정
	leftTransform = CATransform3DIdentity;
	leftTransform = CATransform3DRotate(leftTransform, _coverSideAngle, 0.0f, 1.0f, 0.0f);
	rightTransform = CATransform3DIdentity;
	rightTransform = CATransform3DRotate(rightTransform, _coverSideAngle, 0.0f, -1.0f, 0.0f);
	
	selectedCoverView = nil;
    
	// Set some perspective
	CATransform3D sublayerTransform = CATransform3DIdentity;
	sublayerTransform.m34 = -0.01;
	[scrollView.layer setSublayerTransform:sublayerTransform];
}

/**
 * 초기화
 */
-(void)initialView
{
    _coverImageType = COVER_IMAGE_TYPE_IMAGE;
    _coverBufferCount = DEFAULT_COVER_BUFFER_COUNT;
    _coverReflectionFraction = DEFAULT_COVER_REFLECTION_FRACTION;
    _coverSpacing = DEFAULT_COVER_SPACING;
    _coverCenterOffset = DEFAULT_COVER_CENTER_OFFSET;
    _coverSideAngle = DEFAULT_COVER_SIDE_ANGLE;
    _coverSizeZPosition = DEFAULT_COVER_SIZE_ZPOSITION;
    
	self.multipleTouchEnabled = NO;
	self.userInteractionEnabled = YES;
	self.autoresizesSubviews = YES;
    
    isTouch = NO;
}

/**
 * 데이터를 갱신 한다.
 */
-(void) reloadData
{
    [self setCoverTransform];
    [covers removeAllObjects];
    for (UIView *view in [scrollView subviews]) {
        [view removeFromSuperview];
    }

    NSArray *imageFiles = [self.delegate coverFlowViewImages:self];

    coverImagesCount = 0;
    for (id file in imageFiles) {
        UIImage *image;
        if ( COVER_IMAGE_TYPE_IMAGE == _coverImageType) {
            image = (UIImage*)file;
        }else if ( COVER_IMAGE_TYPE_FILE_NAME == _coverImageType) {
            image = [UIImage imageNamed:(NSString*)file];
        }
        CGFloat imageHeight = image.size.height;
        image = [image addImageReflection:_coverReflectionFraction];
        CoverView *cover = [[CoverView alloc] initWithFrame:CGRectZero];
        [cover setImage:image originalImageHeight:imageHeight reflectionFraction:_coverReflectionFraction];
        [cover setNumber:coverImagesCount coverSpacing:_coverSpacing];
        [covers addObject:cover];
        [scrollView addSubview:cover];
        
        coverImagesCount++;
    }
  	scrollView.contentSize = CGSizeMake(coverImagesCount * _coverSpacing + self.bounds.size.width, self.bounds.size.height);
    
    [self setSelectedCover:0 animated:NO];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)] retain];    
        scrollView.userInteractionEnabled = NO;
        scrollView.multipleTouchEnabled = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:scrollView];

        halfScreenWidth = self.bounds.size.width / 2;
        halfScreenHeight = self.bounds.size.height / 2;

        covers = [[NSMutableArray new] retain];
        [self initialView];
    }
    return self;
}


/**
 * 커버 이미지 위치 및 애니메이션 설정
 */
- (void)layoutCover:(CoverView *)aCover selectedCover:(int)selectedIndex animated:(Boolean)animated  
{
	int lowerBound = MAX(0, selectedIndex - _coverBufferCount);
	int upperBound = MIN(coverImagesCount - 1, selectedIndex + _coverBufferCount);
    if (selectedIndex < lowerBound || selectedIndex > upperBound){
        return;
    }
    

    int coverNumber = aCover.number;
    CATransform3D newTransform;
    CGFloat newZPosition = _coverSizeZPosition;
    CGPoint newPosition;

	newPosition.x = halfScreenWidth + aCover.horizontalPosition;
	newPosition.y = halfScreenHeight + aCover.verticalPosition;
	if (coverNumber < selectedIndex) {
		newPosition.x -= _coverCenterOffset;
		newTransform = leftTransform;
	} else if (coverNumber > selectedIndex) {
		newPosition.x += _coverCenterOffset;
		newTransform = rightTransform;
	} else {
		newZPosition = 0;
		newTransform = CATransform3DIdentity;
	}
	
	if (animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationBeginsFromCurrentState:YES];
	}
	aCover.layer.transform = newTransform;
	aCover.layer.zPosition = newZPosition;
	aCover.layer.position = newPosition;
	
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)dealloc
{
    [scrollView release];
    [covers release];
    [super dealloc];
}

- (void)setSelectedCover:(int)newSelectedCover animated:(BOOL)animated
{
	if (selectedCoverView && (newSelectedCover == selectedCoverView.number) && animated == NO)
		return;
    
    selectedCoverView = (CoverView*)[covers objectAtIndex:newSelectedCover];

	CoverView *cover;
    for (int i = 0; i < coverImagesCount; i++) {
		cover = (CoverView *)[covers objectAtIndex:i];
		[self layoutCover:cover selectedCover:newSelectedCover animated:animated];
	}

    if (!isTouch) {
        // 스크롤뷰를 선택된 셀로 이동
        // 터치 중에는 현재 포인터로 스크롤뷰를 이동
        CGPoint selectedOffset = CGPointMake(_coverSpacing * newSelectedCover, 0);
        [scrollView setContentOffset:selectedOffset animated:animated];
    }
}


- (CoverView *)findCoverOnscreen:(CALayer *)targetLayer 
{
	// See if this layer is one of our covers.
	NSEnumerator *coverEnumerator = [covers objectEnumerator];
	CoverView *aCover = nil;
    aCover = (CoverView *)[coverEnumerator nextObject];
	while (aCover)
    {
		if ([[aCover.imageView layer] isEqual:targetLayer])
			break;
        aCover = (CoverView *)[coverEnumerator nextObject];
    }
	return aCover;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	CGPoint startPoint = [[touches anyObject] locationInView:self];
    isTouch = YES;
	isDraggingACover = NO;
	
	// Which cover did the user tap?
	CALayer *targetLayer = (CALayer *)[scrollView.layer hitTest:startPoint];
	CoverView *targetCover = [self findCoverOnscreen:targetLayer];
	isDraggingACover = (targetCover != nil);
    
	beginningCover = selectedCoverView.number;
	// Make sure the user is tapping on a cover.
	startPosition = (startPoint.x / 1.5) + scrollView.contentOffset.x;
	
	if (isSingleTap)
		isDoubleTap = YES;
    
	isSingleTap = ([touches count] == 1);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	isSingleTap = NO;
	isDoubleTap = NO;
	
	// 드래그 처리
	if (!isDraggingACover)
		return;
	
	CGPoint movedPoint = [[touches anyObject] locationInView:self];
	CGFloat offset = startPosition - (movedPoint.x / 1.5);
	CGPoint newPoint = CGPointMake(offset, 0);
	scrollView.contentOffset = newPoint;
	int newCover = offset / _coverSpacing;
	if (newCover != selectedCoverView.number) {
		if (newCover < 0)
			[self setSelectedCover:0 animated:YES];
		else if (newCover >= coverImagesCount)
			[self setSelectedCover:coverImagesCount - 1 animated:YES];
		else
			[self setSelectedCover:newCover animated:YES];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    isTouch = NO;
	if (isSingleTap) {
		// 싱글 탭 처리
		CGPoint targetPoint = [[touches anyObject] locationInView:self];
		CALayer *targetLayer = (CALayer *)[scrollView.layer hitTest:targetPoint];
		CoverView *targetCover = [self findCoverOnscreen:targetLayer];
		if (targetCover && (targetCover.number != selectedCoverView.number))
			[self setSelectedCover:targetCover.number animated:YES];
	}else{
        [self setSelectedCover:selectedCoverView.number animated:YES];
    }
	
	// And send the delegate the newly selected cover message.
	if (beginningCover != selectedCoverView.number){
        [self.delegate coverFlowViewSelectedImage:self index:selectedCoverView.number];
    }
}

@end
