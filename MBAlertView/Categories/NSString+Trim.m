//
//  NSString+Trim.m
//  AlertsDemo
//
//  Created by Mo Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString*)stringByTruncatingToSize:(CGSize)size withFont:(UIFont*)font addQuotes:(BOOL)addQuotes {
    NSInteger min = 0, max = self.length, mid;
    while (min < max) {
        mid = (min+max)/2;
        
        NSString *currentString = [self substringWithRange:[self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, mid)]];
        CGSize currentSize = [currentString sizeForFont:font constrainedToSize:CGSizeMake(size.width, MAXFLOAT)];
        currentString = nil;
        
        if (currentSize.height < size.height){
            min = mid + 1;
        } else if (currentSize.height > size.height) {
            max = mid - 1;
        } else {
            min = mid;
            break;
        }
    }
    
    /* handle emoji */
    NSMutableString *finalString = [[self substringWithRange:[self rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, min)]] mutableCopy];
    int length = addQuotes ? 4 : 3;
    NSString *appendString = addQuotes ? @"...\"" : @"...";
    if(finalString.length < self.length && finalString.length > length) {
        [finalString replaceCharactersInRange:[finalString rangeOfComposedCharacterSequencesForRange:NSMakeRange(finalString.length - length, length)] withString:appendString];
    }
    return finalString;
}

- (CGSize)sizeForFont:(UIFont *)font
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary* attribs = @{NSFontAttributeName:font};
        return ([self sizeWithAttributes:attribs]);
    }
    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return ([self sizeWithFont:font]);
    #pragma GCC diagnostic pop
}

- (CGSize)sizeForFont:(UIFont *)font constrainedToSize:(CGSize)constraint
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        CGSize boundingBox = [self boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return ([self sizeWithFont:font constrainedToSize:constraint]);
    #pragma GCC diagnostic pop
}

- (CGSize)sizeForFont:(UIFont*)font constrainedToSize:(CGSize)constraint lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        CGSize boundingBox = [self boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
        #pragma GCC diagnostic push
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font constrainedToSize:constraint lineBreakMode:lineBreakMode];
        #pragma GCC diagnostic pop
    }
    
    return size;
}

- (CGSize)sizeForFont:(UIFont *)font
           minFontSize:(CGFloat)minFontSize
        actualFontSize:(CGFloat *)actualFontSize
              forWidth:(CGFloat)width
         lineBreakMode:(NSLineBreakMode)lineBreakMode
{
//    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
//    {
//        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//        paragraphStyle.lineBreakMode = lineBreakMode;
//        
//        NSDictionary* attribs = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
//        return ([self sizeWithAttributes:attribs]);
//    }
    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return ([self sizeWithFont:font minFontSize:minFontSize actualFontSize:actualFontSize forWidth:width lineBreakMode:lineBreakMode]);
    #pragma GCC diagnostic pop
}

- (CGSize)drawInRect:(CGRect)rect
             forFont:(UIFont *)font
       lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = lineBreakMode;
        
        NSDictionary* attribs = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
        CGSize s = [self sizeWithAttributes:attribs];
        [self drawInRect:rect withAttributes:attribs];
        return s;
    }

    #pragma GCC diagnostic push
    #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    return ([self drawInRect:rect withFont:font lineBreakMode:lineBreakMode]);
    #pragma GCC diagnostic pop
}

@end
