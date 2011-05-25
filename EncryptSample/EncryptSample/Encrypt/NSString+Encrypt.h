//
//  NSString+Ecypt.h
//
//  Created by Gyuha Shin on 11. 5. 24..
//  Copyright 2011 dreamers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_Encrypt)

- (NSString *)encryptWithKey:(NSString*)key;
- (NSString *)decryptWithKey:(NSString*)key;
@end
