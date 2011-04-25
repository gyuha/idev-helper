//
//  CoverFlowView.h
//  coverFlow
//
//  Created by Gyuha Shin on 11. 4. 18..
//  Copyright 2011 dreamers. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CoverView.h"

typedef enum __COVER_IMAGE_TYPE
{
    COVER_IMAGE_TYPE_IMAGE = 0,               //!< 커버를 이미지로 사용
    COVER_IMAGE_TYPE_FILE_NAME,         //!< 커버를 이미지 파일 명으로 사용
    COVER_IMAGE_TYPE_COUNT
}COVER_IMAGE_TYPE;

@class CoverFlowView;

@protocol CoverFlowViewDelegate <NSObject>
@required
/**
 * 이미지 목록, 목록은 NSString으로 파일명으로 되어 있음.
 */
- (NSArray*) coverFlowViewImages:(CoverFlowView*)coverFlowView;
/**
 * 선택 된 이미지의 인덱스를 보내 준다.
 */
- (void) coverFlowViewSelectedImage:(CoverFlowView*)coverFlowView index:(NSInteger)index;
@optional
@end

@interface CoverFlowView : UIView {
    id <CoverFlowViewDelegate>  delegate;
    
    UIScrollView        *scrollView;        //!< 스크롤뷰
    
    COVER_IMAGE_TYPE    _coverImageType;            //!< 커버 이미지 형태
    CGFloat             _coverReflectionFraction;   //!< 커버 반사
    CGFloat             _coverSpacing;              //!< 커버 간견
    CGFloat             _coverCenterOffset;         //!< 커버 센터 옵셋
    CGFloat             _coverSideAngle;            //!< 커버 옆 각도
    CGFloat             _coverSizeZPosition;        //!< 커버의 Z 위치
    NSInteger           _coverBufferCount;          //!< 커버에서 액션을 주는 갯수
    
    CoverView			*selectedCoverView;         //!< 선택된 커버
    NSMutableArray      *covers;                    //!< 커버 배열
    NSInteger           coverImagesCount;           //!< 커버 이미지 갯수
    CATransform3D       leftTransform, rightTransform;  //!< 전환 효과
	
	CGFloat             halfScreenHeight;           //!< 화면의 절반 높이
	CGFloat             halfScreenWidth;            //!< 화면의 절반 넓이 

    NSInteger			beginningCover;             //!< 터치 컨트롤 중 처음 시작한 커버
	Boolean             isSingleTap;                //!< 탭
	Boolean             isDoubleTap;                //!< 더블탭
	Boolean             isDraggingACover;           //!< 드래그
    Boolean             isTouch;                    //!< 탭 했음
	CGFloat             startPosition;              //!< 시작 위치
}

@property (nonatomic, retain) id<CoverFlowViewDelegate> delegate;
@property (nonatomic, assign) COVER_IMAGE_TYPE coverImageType;
@property (nonatomic, assign) NSInteger coverBufferCount;
@property (nonatomic, assign) CGFloat coverReflectionFraction;
@property (nonatomic, assign) CGFloat coverSpacing;
@property (nonatomic, assign) CGFloat coverCenterOffset;
@property (nonatomic, assign) CGFloat coverSideAngle;
@property (nonatomic, assign) CGFloat coverSizeZPosition;

- (void) setSelectedCover:(int)newSelectedCover animated:(BOOL)animated;
- (void) reloadData;
@end
