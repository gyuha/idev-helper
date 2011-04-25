//
//  SlideMenuView.h
//  slideMenu
//
//  Created by Gyuha Shin on 11. 4. 12..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideMenuView;

@protocol SlideMenuViewDelegate <NSObject>

@required
- (NSArray*) slideMenuViewImages:(SlideMenuView*)slideMenuView;
/** 
 * 슬라이드에서 선택 된 이미지
 */
- (void) slideMenuViewClick:(SlideMenuView*)slideMenuView selectIndex:(NSInteger)index;

@optional
/**
 * 슬라이드 배경 색
 */
- (UIColor*)slideMenuBackgroundColor:(SlideMenuView*)slideMenuView;
- (Boolean) enableItem:(SlideMenuView*)slideMenuView;

@end

@interface SlideMenuView : UIView <UIScrollViewDelegate> {
    @private
    UIScrollView *menuScrollView;
    id<SlideMenuViewDelegate> _delegate;
    
    CGRect          _slideMenuRect;     //!< 슬라이드 메뉴 위치 및 사이즈
    UIColor         *_bgColor;  //!< 배경 색상
    CGSize          _imageSize;         //!< 이미지의 크기
    CGFloat         _borderDeep;        //!< 보더 깊이
    CGFloat         _topMargin;         //!< 아래 마진
    CGFloat         _bottomMargin;      //!< 아래 마진    
    CGFloat         _imageMargin;       //!< 이미지 사이의 간격
    UIColor         *_selectedColor;      //!< 보더 색상
    NSInteger       _seletctedItem;     //!< 선택된 아이템
}

- (id) initWithFrame:(CGRect)frame;
- (void) reloadData;
- (void) updateSeletedButton;
- (void) updateRect;

@property (nonatomic, assign) IBOutlet id<SlideMenuViewDelegate> delegate;
@property (nonatomic, assign) CGRect slideMenuRect;
@property (nonatomic, retain) UIColor *bgColor;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat borderDeep;
@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat imageMargin;
@property (nonatomic, retain) UIColor *selectedColor;
@property (nonatomic, assign) NSInteger selectedItem;


@end
