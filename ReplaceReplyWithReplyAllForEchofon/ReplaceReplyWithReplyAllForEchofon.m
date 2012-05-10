//
//  ReplaceReplyWithReplyAllForEchofon.m
//  ReplaceReplyWithReplyAllForEchofon
//
//  Created by Linghua Zhang on 12/05/10.
//  Copyright (c) 2012年 lhzhang.com. All rights reserved.
//

#import "ReplaceReplyWithReplyAllForEchofon.h"
#import <objc/runtime.h>

@implementation NSObject(ReplyAllForEchoFon)

- (void)startReplyAll:(id)arg
{
    [self startReplyAll:arg];
    
    static Ivar ivar;
    if (!ivar) {
        ivar = class_getInstanceVariable([self class], "text");
    }
    if (ivar) {
        NSTextView *textView = object_getIvar(self, ivar);
        NSString *string = textView.string;
        NSInteger loc = [string rangeOfString:@" "].location + 1;
        NSInteger len = string.length - loc;
        [textView setSelectedRange:NSMakeRange(loc, len)];
    }
}

@end

@implementation ReplaceReplyWithReplyAllForEchofon

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(objc_getClass("MainWindowController"), @selector(startReply:)),
                                   class_getInstanceMethod(objc_getClass("NSObject"), @selector(startReplyAll:)));
    
    NSLog(@"ReplyAllForEchoFon installed");
}

@end
