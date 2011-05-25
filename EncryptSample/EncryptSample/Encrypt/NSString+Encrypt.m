//
//  NSString+Ecypt.m
//
//  Created by Gyuha Shin on 11. 5. 24..
//  Copyright 2011 dreamers. All rights reserved.
//

#import "NSString+Encrypt.h"
#import "NSDataAdditions.h"
#import "NSData+AES256.h"

@implementation NSString (NSString_Encrypt)

- (NSString *)encryptWithKey:(NSString*)key
{
    NSData *data = [self dataUsingEncoding: NSUTF8StringEncoding];
    data = [data AES256EncryptWithKey:key];    
    NSString *result = [data base64Encoding];
    return result;
}

- (NSString *)decryptWithKey:(NSString *)key
{
    NSData *decodedData = [NSData dataWithBase64EncodedString:self];
    decodedData = [decodedData AES256DecryptWithKey:key];
    NSString *result = [[[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding] autorelease];
    return result;
}

@end
