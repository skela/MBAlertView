//
//  NSString+Trim.h
//  AlertsDemo
//
//  Created by Mo Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

- (NSString*)stringByTruncatingToSize:(CGSize)size
                             withFont:(UIFont*)font
                            addQuotes:(BOOL)addQuotes;

- (CGSize)sizeForFont:(UIFont *)font;

- (CGSize)sizeForFont:(UIFont *)font
    constrainedToSize:(CGSize)constraint;

- (CGSize)sizeForFont:(UIFont*)font
    constrainedToSize:(CGSize)constraint
        lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeForFont:(UIFont *)font
           minFontSize:(CGFloat)minFontSize
        actualFontSize:(CGFloat *)actualFontSize
              forWidth:(CGFloat)width
         lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)drawInRect:(CGRect)rect forFont:(UIFont *)font
       lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
