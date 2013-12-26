#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "NSData+QBase64.h" //add by zhenwei
//#import "N"    //add by zhenwei

@interface NSString (LSAdditional)

/**
 * Determines if the string contains only whitespace.
 */ 
- (BOOL)isWhitespace;

/**
 * Determines if the string is empty or contains only whitespace.
 */ 
- (BOOL)isEmptyOrWhitespace;

/**
 * Checks to see if the string contains the given string, case insenstive
 */
- (BOOL)containsString:(NSString*)string;

/**
 * Checks to see if the string contains the given string while allowing you to define the compare options
 */
- (BOOL)containsString:(NSString*)string options:(NSStringCompareOptions)options;

/**
 * Returns the MD5 value of the string
 */
//- (NSString*)md5;


- (NSString*)encodeAsURIComponent;

- (NSString *)encodingURL;

/// Get a string where internal characters that need escaping for HTML are escaped 
//
///  For example, '&' become '&amp;'. This will only cover characters from table
///  A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
///  which is what you want for a unicode encoded webpage. If you have a ascii
///  or non-encoded webpage, please use stringByEscapingAsciiHTML which will
///  encode all characters.
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByEscapingForHTML;

/// Get a string where internal characters that need escaping for HTML are escaped 
//
///  For example, '&' become '&amp;'
///  All non-mapped characters (unicode that don't have a &keyword; mapping)
///  will be converted to the appropriate &#xxx; value. If your webpage is
///  unicode encoded (UTF16 or UTF8) use stringByEscapingHTML instead as it is
///  faster, and produces less bloated and more readable HTML (as long as you
///  are using a unicode compliant HTML reader).
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByEscapingForAsciiHTML;

/// Get a string where internal characters that are escaped for HTML are unescaped 
//
///  For example, '&amp;' becomes '&'
///  Handles &#32; and &#x32; cases as well
///
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByUnescapingFromHTML;

- (NSString *)flattenHTML;

- (CGFloat)widthWithFont:(UIFont *)font;

@end
