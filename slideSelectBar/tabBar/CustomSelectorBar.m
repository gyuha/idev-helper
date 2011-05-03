//
//  CustomSelectorBar.m
//  tabBar
//
//  Created by Gyuha Shin on 11. 5. 2..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "CustomSelectorBar.h"


@implementation CustomSelectorBar
@synthesize 
barRect = _selfRect,
delegate = _delegate, 
bgColor = _bgColor,
font = _font,
buttonSize = _buttonSize,
buttonMargin = _buttonMargin, 
leftCapWidth = _leftCapWidth,
topCapHeight = _topCapHeight,
selectedItem = _seletctedItem,
verticalAlign = _verticalAlign,
align = _align;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selfRect = frame;
        _bgColor = [UIColor blackColor];
        _buttonSize = CGSizeMake(frame.size.height, frame.size.height);
        _buttonMargin = 0.0f;
        _seletctedItem = 0;
        _verticalAlign = VerticalAlignBottom;
        _align = AlignLeft;
        _leftCapWidth = 0.0f;
        _topCapHeight = 0.0f;
        _font = [UIFont systemFontOfSize:15];
        
        
        // 스크롤뷰 만들기
		menuScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)] retain];
        
		menuScrollView.backgroundColor = _bgColor;
		menuScrollView.showsHorizontalScrollIndicator = FALSE;
		menuScrollView.showsVerticalScrollIndicator = FALSE;
		menuScrollView.scrollEnabled = YES;
		menuScrollView.bounces = YES;
		menuScrollView.delegate = self;
        
   		[self addSubview:menuScrollView];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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

    NSInteger tag = 0;
    NSArray *titleArray = [self.delegate CustomSelectorBarTextItems:self];
    float y;
    switch (_verticalAlign) {
        case VerticalAlignTop:
            y = 0;
            break;
        case VerticalAlignMiddle:
            y = (_selfRect.size.height - _buttonSize.height) / 2;
            break;
        case VerticalAlignBottom:
            y = (_selfRect.size.height - _buttonSize.height);
            break;
        default:
            y = 0;
            break;
    }

    int buttonCount = [titleArray count];
    
    float startX;
    int totalWidth = buttonCount*(_buttonSize.width * _buttonMargin);    
    switch (_align) {
        case AlignLeft:
            startX = 0;
            break;
        case AlignCenter:
            if (_selfRect.size.width < totalWidth) {
                startX = (totalWidth - _selfRect.size.width)/2;
            }else{
                startX = 0;
            }
            break;
        case AlignRight:
            if (_selfRect.size.width < totalWidth) {
                startX = totalWidth - _selfRect.size.width;
            }else{
                startX = 0;
            }
            break;
        default:
            startX = 0;
            break;
    }
    
    float totalButtonWidth = startX;
    for (NSString *title in titleArray) {
        float x = totalButtonWidth;
        CGRect buttonRect = CGRectMake(x, y, _buttonSize.width, _buttonSize.height);
        UIButton *button = [[UIButton alloc] initWithFrame:buttonRect];
        button.tag = tag;
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        button.enabled = YES;
        button.highlighted = NO;
        [button.titleLabel setFont:_font];
        [menuScrollView addSubview:button];
        totalButtonWidth = totalButtonWidth + _buttonSize.width + _buttonMargin;
        tag++;
    }
    [menuScrollView setContentSize:CGSizeMake(totalButtonWidth+_buttonMargin, _selfRect.size.height)];
    self.backgroundColor = menuScrollView.backgroundColor = _bgColor;
    [self updateSeletedButton];
    [self updateSeletedButton];
       [self updateSeletedButton]; 
    
}

- (void) updateSeletedButton
{
    NSInteger idx = 0;
    for(UIButton *button in [menuScrollView subviews]) {
        Boolean flag = NO;
        if (idx == _seletctedItem) flag = YES;
        [button setBackgroundImage:[[self.delegate CustomSelectorBar:self buttonImages:flag] stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapHeight] forState:UIControlStateNormal];
        idx++;
    }
}

- (void) updateRect
{
    self.frame = _selfRect;
    menuScrollView.frame = CGRectMake(0.0f, 0.0f, _selfRect.size.width, _selfRect.size.height);
}


-(void)onButtonClick:(id)sender
{
    NSInteger index = ((UIButton*)sender).tag;
    _seletctedItem = index;
    [self.delegate CustomSelectorBar:self selectedIndex:_seletctedItem];
    [self updateSeletedButton];
}


@end
