//
//  workflow.m
//  WorkflowObjC
//
//  Created by Michael Boosalis on 5/22/16.
//  Copyright © 2016 Michael Boosalis, Lord Of The Game. All rights reserved, under penalty of death.
//

#import <Cocoa/Cocoa.h>
#include "workflow.h"


///////////////////////////////////////////////////////////////////////////////////////

// must alloc anyway, size is dynamic
//void toUnichars (NSString* ns, unichar* cs) {
//    NSUInteger l = [ns length];
//    [ns getCharacters:cs range:NSMakeRange(0,l)];
//    // NSRange NSMakeRange(NSUInteger loc, NSUInteger len)
//}

NSString* fromUTF8(const char* s) {
    return [[NSString alloc]
            initWithCString:s encoding:NSUTF8StringEncoding];
}

const char* toUTF8(NSString* s) {
    return [s cStringUsingEncoding:NSUTF8StringEncoding];
}

unichar* toUnichars (NSString* ns) {
    NSUInteger l = [ns length];
    unichar* s16 = (unichar*) malloc(l * sizeof(unichar));
    [ns getCharacters:s16 range:NSMakeRange(0,l)];
    // NSRange NSMakeRange(NSUInteger loc, NSUInteger len)
    return s16;
}

///////////////////////////////////////////////////////////////////////////////////////


/*

 https://developer.apple.com/library/mac/documentation/Carbon/Reference/QuartzEventServicesRef

http://stackoverflow.com/questions/1117065/cocoa-getting-the-current-mouse-position-on-the-screen

 CGPointMake(CGFloat x, CGFloat y)
 {
 CGPoint p; p.x = x; p.y = y; return p;
 }

 */
void clickMouseAt

(CGEventFlags modifiers,
 UInt32 numClicks,
 CGMouseButton mouseButton, CGEventType mouseDown, CGEventType mouseUp,
 CGFloat x, CGFloat y) {
    
    CGPoint p = CGPointMake(x,y);
    
    CGEventRef eventDown = CGEventCreateMouseEvent(NULL, mouseDown, p, mouseButton);
    CGEventRef eventUp   = CGEventCreateMouseEvent(NULL, mouseUp,   p, mouseButton);
    
    // hold down modifiers
    CGEventSetFlags(eventDown, modifiers);
    CGEventSetFlags(eventUp,   modifiers);
    
    // click numClicks times. each click must say which it is (1st, 2nd, 3rd, etc)
    
    for (int nthClick=1; nthClick<=numClicks; nthClick++) {
        CGEventSetIntegerValueField(eventDown, kCGMouseEventClickState, nthClick);
        CGEventPost(kCGHIDEventTap, eventDown);

        CGEventSetIntegerValueField(eventUp,   kCGMouseEventClickState, nthClick);
        CGEventPost(kCGHIDEventTap, eventUp);
        [NSThread sleepForTimeInterval:0.30f]; //30ms
    }
    
    // free memory
    CFRelease(eventDown);
    CFRelease(eventUp);
}

void clickMouse
(CGEventFlags modifiers, UInt32 numClicks, CGMouseButton mouseButton, CGEventType mouseDown, CGEventType mouseUp) {
    CGPoint p;
    getCursorPosition(&p);
    clickMouseAt(modifiers,  numClicks,  mouseButton,  mouseDown,  mouseUp, p.x,  p.y);
}

/*
 a unicode string from haskell, utf8-encoded or "un-encoded"?
 */
void sendText(const char* s0) {
    NSString* s8 = fromUTF8(s0);
    sendNSText(s8);
}

void sendNSText(NSString* s) {
    unichar* s16 = toUnichars(s);
    
    CGEventSourceRef eventSource = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    CGEventRef down;
    down = CGEventCreateKeyboardEvent(eventSource, 1, true);
    
    CGEventKeyboardSetUnicodeString(down, [s length], s16);
    CGEventPost(kCGHIDEventTap, down);
    
    CFRelease(down);
}

/*
 CGEventCreateKeyboardEvent(CGEventSourceRef __nullable source, CGKeyCode virtualKey, bool keyDown)
 
 */
void sendUnichar (unichar c) {
    CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStateHIDSystemState);
    CGEventRef down = CGEventCreateKeyboardEvent(source, 0, true);
    CGEventRef up   = CGEventCreateKeyboardEvent(source, 0, false);
    
    CGEventKeyboardSetUnicodeString(down, 1, &c);
    CGEventPost(kCGHIDEventTap, down);
    CGEventKeyboardSetUnicodeString(up, 1, &c);
    CGEventPost(kCGHIDEventTap, up);
    
    CFRelease(down);
    CFRelease(up);
}


void getCursorPosition(CGPoint* p) {
    *p = CGEventGetLocation(CGEventCreate(NULL));
}

/*
 http://stackoverflow.com/questions/8059667/set-the-mouse-location
 */
void setCursorPosition(CGFloat x, CGFloat y) {
    // CGPoint p;
    // p.x = x;
    // p.y = y;
    
    CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    CGEventRef mouse = CGEventCreateMouseEvent (NULL, kCGEventMouseMoved, CGPointMake(x,y), 0);
    
    CGEventPost(kCGHIDEventTap, mouse);
    
    CFRelease(mouse);
    CFRelease(source);
}
