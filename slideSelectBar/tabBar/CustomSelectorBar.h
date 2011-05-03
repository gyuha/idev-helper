//
//  CustomSelectorBar.h
//  tabBar
//
//  Created by Gyuha Shin on 11. 5. 2..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum __VERTICAL_ALIGN__
{
    VerticalAlignTop = 0,
    VerticalAlignMiddle,
    VerticalAlignBottom,
    VerticalAlignCount
}CustomSelectorBarVerticalAlign;

typedef enum __ALIGN__
{
    AlignLeft = 0,
    AlignCenter,
    AlignRight,
    AlignCount
}CustomSelectorBarAlign;

@class CustomSelectorBar;
@protocol CustomSelectorBarDelegate <NSObject>

@required
/**
 * 아이템 텍스트의 배열
 */
- (NSArray*) CustomSelectorBarTextItems:(CustomSelectorBar*)customSelectorBar;
/**
 * 선택된 인덱스
 */
- (void) CustomSelectorBar:(CustomSelectorBar*)customSelectorBar selectedIndex:(NSInteger)index;
/**
 * 바 버튼의 이미지
 * select : YES 선택, NO 비활성화
 */
- (UIImage*) CustomSelectorBar:(CustomSelectorBar*)customSelectorBar buttonImages:(Boolean)select;
@end

@interface CustomSelectorBar : UIView <UIScrollViewDelegate>{
    @private
    UIScrollView *menuScrollView;
    id<CustomSelectorBarDelegate> _delegate;
    
    CGRect          _selfRect;          //!< 슬라이드 메뉴 위치 및 사이즈
    UIColor         *_bgColor;          //!< 배경 색상
    CGSize          _buttonSize;        //!< 이미지의 크기
    CGFloat         _buttonMargin;      //!< 이미지 사이의 간격
    NSInteger       _seletctedItem;     //!< 선택된 아이템
    NSInteger       _leftCapWidth;      //!< 버튼의 좌측 자르기
    NSInteger       _topCapHeight;      //!< 버튼의 상하 자르기
    UIFont          *font;
    
    CustomSelectorBarVerticalAlign  _verticalAlign; //!< 세로 정렬
    CustomSelectorBarAlign          _align;         //!< 가로 정렬
}

- (id) initWithFrame:(CGRect)frame;
- (void) reloadData;
- (void) updateSeletedButton;
- (void) updateRect;

@property (nonatomic, assign) IBOutlet id<CustomSelectorBarDelegate> delegate;
@property (nonatomic, assign) CGRect barRect;
@property (nonatomic, retain) UIColor *bgColor;
@property (nonatomic, retain) UIFont  *font;
@property (nonatomic, assign) CGSize  buttonSize;
@property (nonatomic, assign) CGFloat buttonMargin;
@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, assign) NSInteger leftCapWidth;      //!< 버튼의 좌측 자르기
@property (nonatomic, assign) NSInteger topCapHeight;      //!< 버튼의 상하 자르기
@property (nonatomic, assign) CustomSelectorBarVerticalAlign  verticalAlign;
@property (nonatomic, assign) CustomSelectorBarAlign          align;

@end
