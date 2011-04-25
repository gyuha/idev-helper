//
//  CoverView.h
//  coverFlow
//
//  Created by Gyuha Shin on 11. 4. 19..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CoverView : UIView {
    UIImageView     *_imageView;
    NSInteger       _number;
    CGFloat         _horizontalPosition;
    CGFloat         _verticalPosition;
    CGFloat         _originalImageHeight;
}

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, readonly) CGFloat horizontalPosition;
@property (nonatomic, readonly) CGFloat verticalPosition;
@property (nonatomic, readonly) UIImageView *imageView;

- (void)setImage:(UIImage *)image originalImageHeight:(CGFloat)imageHeight reflectionFraction:(CGFloat)reflectionFraction;
- (CGSize)calculateNewSize:(CGSize)baseImageSize boundingBox:(CGSize)boundingBox;
- (void)setNumber:(NSInteger)number coverSpacing:(CGFloat)coverSpacing;

@end
