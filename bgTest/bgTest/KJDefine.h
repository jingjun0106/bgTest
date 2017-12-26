//
//  KJDefine.h
//  bgTest
//
//  Created by 오픈태스크iOS on 2017. 12. 14..
//  Copyright © 2017년 오픈태스크iOS. All rights reserved.
//

#ifndef KJDefine_h
#define KJDefine_h

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define _ASSERT(must_be_true)  NSAssert(must_be_true, @"ASSERT (%s)", #must_be_true )
#define _ASSERTNIL(must_not_null) NSAssert(must_not_null !=nil && ![must_not_null isKindOfClass:[NSNull class]]  , @" _ASSERTNIL #(%s)%@ ", #must_not_null, must_not_null == nil ? @"" : [NSString stringWithFormat:@"<%@>",  NSStringFromClass([must_not_null class])] )
#define _ASSERTSTR(must_not_empty) NSAssert( [must_not_empty isKindOfClass:[NSString class]] &&  must_not_empty.length > 0, @"\n\n%s line:%d\n" , __FUNCTION__,__LINE__)

#define LOG_ERROR( s, ... ) NSLog( @" *** ERROR in %s(L:%d), \'%@\'",  __FUNCTION__, __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__])
#define LOG_OBJECT( obj ) NSLog(@"LOG_OBJECT(%s)<%@>:%@, %s(L:%d)",#obj, NSStringFromClass([obj class]), obj, __FUNCTION__, __LINE__)
#define _DLOG( s, ... ) NSLog( @"%@", [NSString stringWithFormat:(s), ##__VA_ARGS__])

#else

#define _ASSERT(must_be_true)
#define _ASSERTNIL(must_not_null)
#define _ASSERTSTR(must_not_empty)

#define LOG_ERROR( s, ... )
#define LOG_OBJECT( obj )
#define _DLOG( s, ... )

#endif


#define BARBUTTON(TITLE, SELECTOR)     [[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]

#define SHOWALERT_ERROR(operation, error) [[[UIAlertView alloc] initWithTitle:[error localizedDescription] \
message:[NSString stringWithFormat:@"(%@)", operation==nil?@"NETWORK ERROR":[operation.request.URL absoluteString]] \
delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

#define SHOWALERT_MAIN(TITLE,MSG) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:TITLE message:MSG delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; \
dispatch_async (dispatch_get_main_queue(), ^{ [alertView show]; })

#define DEBUG_ON  1 // 0 : Debug Off, 1 : Debug On
#define TRACE_ON  1


#if TRACE_ON
#define TRACE_WITH(format, ...) NSLog(@"%@ %@", \
[[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] lastPathComponent],\
[NSString stringWithFormat:(format), ##__VA_ARGS__])
#define TRACE() NSLog(@"%@", [[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding] lastPathComponent])
#else
#define TRACE_WITH(format, ...)
#define TRACE()
#endif



//***********************************************************//
// calculate estimate time
// set this YES to show elasp time
#define CALCULATE_TIME YES

#define CALCULATE_BEGIN NSDate *DebugMethodStart;if(CALCULATE_TIME){DebugMethodStart = [NSDate date];}
#define CALCULATE_END NSTimeInterval _executionTime;if(CALCULATE_TIME){_executionTime = [[NSDate date] timeIntervalSinceDate:DebugMethodStart];}
#define CALCULATE_EXECUTION_TIME (CALCULATE_TIME?_executionTime:0)
#define CALCULATE_EXECUTION_TIME_LOG(msg) _DLOG(@"*[%@] ... %fsec", msg, CALCULATE_EXECUTION_TIME);
//***********************************************************//

#define SCREEN_SIZE ([UIScreen mainScreen].bounds.size)
#define TAB_HEIGHT self.tabBarController.tabBar.bounds.size.height
#define STATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#define _VERIFY_STR(content) ([content isKindOfClass:[NSString class]] && [content length] > 0)
#define _VERIFY_OBJECT(content, className) ([content isKindOfClass:[className class]] && [content count] > 0)
#define _VERIFY_DICTIONARY(content) ([content isKindOfClass:[NSDictionary class]] && [content count] > 0)
#define _VERIFY_ARRAY(content) ([content isKindOfClass:[NSArray class]] && [content count] > 0)
#define _VERIFY_NUMBER(logid) [logid isKindOfClass:[NSNumber class]]


#define _BOTTOM_HEIGHT(view) (view.frame.origin.y + view.frame.size.height)
#define _RIGHT(view) (view.frame.origin.x + view.frame.size.width)
#define _LEFT(viwe) (view.frame.origin.x)
#define _TOP(view) (view.frame.origin.y)
#define _INSETS_WIDTH(insets) (insets.left + insets.right)
#define _INSETS_HEIGHT(insets) (insets.top + insets.bottom)
#define _SAFE_STR(str) ( str && [str isKindOfClass:[NSString class]] ) ? str : @""
#define _SAFR_INTEGER(value) ([value isKindOfClass:[NSNumber class]]) ? [value integerValue] : (([value isKindOfClass:[NSString class]]) ? [value integerValue] : 0)


#define _SDGOTHIC_REGULAR @"AppleSDGothicNeo-Regular"

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kNaviHeight (44.0 + [[UIApplication sharedApplication] statusBarFrame].size.height)

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define IOS_VERSION_OVER_8_0 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 )
#define IOS_VERSION_OVER_9_0 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 )

#define __IPHONE_OS_VERSION_OVER_8_0 (__IPHONE_OS_VERSION_MAX_ALLOWED >= 80000)

#endif /* KJDefine_h */




