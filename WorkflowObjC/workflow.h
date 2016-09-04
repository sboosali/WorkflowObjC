//
//  workflow.h
//  WorkflowObjC
//
//  Created by Michael Boosalis on 5/22/16.
//  Copyright © 2016 Michael Boosalis, Lord Of The Game. All rights reserved.
//

#ifndef workflow_h
#define workflow_h
#endif /* workflow_h */

#import <Cocoa/Cocoa.h>

void clickMouseAt
(CGEventFlags modifiers,
 UInt32 numClicks,
 CGMouseButton mouseButton, CGEventType mouseDown, CGEventType mouseUp,
 CGFloat x, CGFloat y);

void clickMouse
(CGEventFlags modifiers, UInt32 numClicks, CGMouseButton mouseButton, CGEventType mouseDown, CGEventType mouseUp);

void getCursorPosition (CGPoint*);
void setCursorPosition(CGFloat x, CGFloat y);

void sendText(const char* s);
void sendNSText(NSString* s);
void sendUnichar (unichar c);

