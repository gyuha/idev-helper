//
//  NSData+AES256.h
//

#import <Foundation/Foundation.h>


@interface NSData (NSData_AES256)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end
