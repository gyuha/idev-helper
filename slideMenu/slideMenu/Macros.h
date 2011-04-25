//
//  UsefulMacros.h
//  ComicViewer
//
//  Created by Gyuha Shin on 11. 3. 18..
//  Copyright 2011 dreamers. All rights reserved.
//
// iOS4 버전 구분해 주기
#define IS_OS4 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)

#define DOCUMENTS_PATH      [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define APP_PATH            [NSString stringWithFormat:@"%@/", [[NSBundle mainBundle] bundlePath]]

// 현재의 언어를 가져 온다.
#define LANGUAGE			[NSString stringWithFormat:@"%@", [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0]]

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
#pragma mark - Math

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
#define RADIANS_TO_DEGREES(r) (r * 180 / M_PI)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
#pragma mark - 색상용

#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:1.f]

#define RGBACOLOR(r,g,b,a) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]

#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#pragma mark - 프레임
#define width(a) a.frame.size.width
#define height(a) a.frame.size.height
#define top(a) a.frame.origin.y
#define left(a) a.frame.origin.x
#define FrameReposition(a,x,y) a.frame = CGRectMake(x, y, width(a), height(a))
#define FrameResize(a,w,h) a.frame = CGRectMake(left(a), top(a), w, h)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
#pragma mark -
#pragma mark SAFELY RELSEASE
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define AUTORELEASE_SAFELY(__POINTER) { [__POINTER autorelease]; __POINTER = nil; }
#define RELEASE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
#pragma mark - 디버그용

#define MARK	CFShow([NSString stringWithFormat:@"%s [%d]", __FUNCTION__, __LINE__]);

#if TARGET_IPHONE_SIMULATOR

#define LOG(format, ...) \
CFShow([NSString stringWithFormat:@"%s[%d] : %@", \
__PRETTY_FUNCTION__,  __LINE__ ,\
[NSString stringWithFormat:format, ## __VA_ARGS__] ]);
#define Log(format, ...) \
NSLog([NSString stringWithFormat:@"%@%d: %@", \
[[[NSString alloc] initWithBytes:__FILE__ length:strlen(__FILE__) encoding:NSUTF8StringEncoding] lastPathComponent] ,\
__LINE__, [NSString stringWithFormat:format, ## __VA_ARGS__]]);
#define ASSERT(STATEMENT) do { assert(STATEMENT); } while(0)

#else

#define LOG(format, ...)
#define Log(format, ...)
#define ASSERT(STATEMENT) do { (void)sizeof(STATEMENT);} while(0)

#endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
// 사이즈용 디버그 출력
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
#define debugRect(rect) LOG(@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define debugSize(size) LOG(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define debugPoint(point) LOG(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//코드 수행 시간 측정
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
#if TARGET_IPHONE_SIMULATOR
    #define GET_TICK_COUNT_START(NAME) NSDate *__##NAME = [NSDate date]
    #define GET_TICK_COUNT_END(NAME) NSTimeInterval __elapsed_##NAME = [__##NAME timeIntervalSinceNow] * -1000.0; \
        NSLog(@"%s runtime : %f", #NAME, __elapsed_##NAME)
#else
    #define GET_TICK_COUNT_START(NAME)
    #define GET_TICK_COUNT_END(NAME)
#endif
