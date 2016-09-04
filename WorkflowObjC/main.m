#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#include "workflow.h"

/*
 aα
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello, World!");
        

        NSLog(@"Clicking...");
        [NSThread sleepForTimeInterval:1.0f];

        CGEventFlags modifiers = 0;
        CGMouseButton mouseButton = kCGMouseButtonLeft;
        CGEventType mouseDown = NX_LMOUSEDOWN;
        CGEventType mouseUp = kCGEventLeftMouseUp;
        UInt32 numClicks = 3;
        CGFloat x = 0;
        CGFloat y = 0;
        
        clickMouseAt( modifiers,  numClicks,  mouseButton,  mouseDown,  mouseUp,  x,  y);
//
//        CGPoint p;
//        getCursorPosition(&p);
//        NSLog(@"{x,y} = {%f,%f}", p.x, p.y);
//        // 2016-05-22 14:56:40.351 WorkflowObjC[40534:440281] {x,y} = {1439.000000,899.000000}
//        // CFRelease(p); // CGPoint is a struct
//
        

//        NSLog(@"inserting...");
//        [NSThread sleepForTimeInterval:1.0f];
//
//        const char *greek16 = "\0x03B1\0x03B2\0x03B3"; // 0x03B1
//        const char *greek8 = "\0xCE\0xB1\0xCE\0xB2\0xCE\0xB3"; // 0xCE 0xB1
//
//        //sendText("abc");
//        sendText(greek8);
//        sendText("\n");
//        sendText(greek16);
//
        //sendNSText(@"x");
        //sendNSText(@"abc");
        //sendNSText(@"\n");
        //sendNSText(@"\0x03B1\0x03B2\0x03B3");
        
//        sendUnichar(97);     // a
//        [NSThread sleepForTimeInterval:0.030f]; // without delay, the next events are dropped
//        sendUnichar(0x03B1); // α
        
//        
//                NSLog(@"moving...");
//                [NSThread sleepForTimeInterval:1.0f];
//        setCursorPosition(0,0);
        
    }
    return 0;
}
