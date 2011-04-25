//
//  SlideMenuView.m
//  slideMenu
//
//  Created by Gyuha Shin on 11. 4. 12..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "SlideMenuView.h"
#import "QuartzCore/QuartzCore.h"

@implementation SlideMenuView

@synthesize 
slideMenuRect = _slideMenuRect,
delegate = _delegate, 
bgColor = _bgColor,
imageSize = _imageSize,
borderDeep = _borderDeep,
topMargin = _topMargin,
bottomMargin = _bottomMargin,
imageMargin = _imageMargin, 
selectedColor = _selectedColor,
selectedItem = _seletctedItem;

/**
 * 해당 버튼의 보더를 표시해 준다.
 * @see selectedItem
 */
- (void) updateSeletedButton
{
    NSInteger idx = 0;
    for(UIButton *button in [menuScrollView subviews]) {
        CALayer * btnLayer = [button layer];
        [btnLayer setMasksToBounds:YES];        
        if (idx == _seletctedItem) {
            [btnLayer setBorderWidth:_borderDeep];
        }else{
            [btnLayer setBorderWidth:0];            
        }
        [btnLayer setBorderColor:[_selectedColor CGColor]];
        idx++;
    }
}

/**
 * 위치나 사이즈를 갱신 했을 경우 처리
 * @see slideMenuRect
 */
- (void) updateRect
{
    self.frame = _slideMenuRect;
    menuScrollView.frame = CGRectMake(0.0f, 0.0f, _slideMenuRect.size.width, _slideMenuRect.size.height);
}

/**
 * View의 내용을 갱신
 */
- (void) reloadData
{
    for(UIButton *button in [menuScrollView subviews]) {
        [button removeFromSuperview];
    }
    
    [self updateRect];
    
    float totalButtonWidth = 0.0f;
    NSInteger tag = 0;
    NSArray *imgArray = [self.delegate slideMenuViewImages:self];
    for (NSString *fileName in imgArray) {
        float x = totalButtonWidth + _imageMargin;        
        CGRect buttonRect = CGRectMake(x, _topMargin, _imageSize.width, _imageSize.height);
        UIButton *button = [[UIButton alloc] initWithFrame:buttonRect];
        button.tag = tag;
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage imageNamed:fileName];        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [menuScrollView addSubview:button];
        totalButtonWidth = totalButtonWidth + _imageSize.width + _imageMargin;
        tag++;
    }
    [menuScrollView setContentSize:CGSizeMake(totalButtonWidth+_imageMargin, self.frame.size.height)];
    [self updateSeletedButton];

}

-(void)onButtonClick:(id)sender
{
    _seletctedItem = ((UIButton*)sender).tag;
    [self.delegate slideMenuViewClick:self selectIndex:_seletctedItem];
    [self updateSeletedButton];
}

/**
 * 이미지 슬라이드 초기화
 */
- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        // 변수들 초기화        
        _slideMenuRect = frame;
        self.backgroundColor = [UIColor blackColor];
        _selectedColor = [UIColor grayColor];
        _topMargin = 8.0f;
        _bottomMargin = 8.0f;
        _imageMargin = 5.0f;
        CGFloat imgSize = frame.size.height - _topMargin - _bottomMargin;
        _imageSize = CGSizeMake(imgSize, imgSize);
        _borderDeep = 3.0f;
        _seletctedItem = 0;

        // 스크롤뷰 만들기
		menuScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)] retain];
        
		menuScrollView.backgroundColor = self.backgroundColor;
		menuScrollView.showsHorizontalScrollIndicator = FALSE;
		menuScrollView.showsVerticalScrollIndicator = FALSE;
		menuScrollView.scrollEnabled = YES;
		menuScrollView.bounces = YES;
		menuScrollView.delegate = self;
        
   		[self addSubview:menuScrollView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if(scrollView.contentOffset.x <= 3)
	{
//		NSLog(@"Scroll is as far left as possible");
	}
	else if(scrollView.contentOffset.x >= (scrollView.contentSize.width - scrollView.frame.size.width)-3)
	{
//		NSLog(@"Scroll is as far right as possible");
	}
	else
	{
	}
    
}


- (void)dealloc
{
    [menuScrollView release];
    [super dealloc];
}

@end
