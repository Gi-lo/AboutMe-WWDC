/* ----------------------------------------------------------------------
 
 CAAnimation+CompletionBlock.m
 
 Created by Giulio Petek on 17.4.2013.
 
 Copyright (c) 2013 Giulio Petek. All rights reserved.
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ---------------------------------------------------------------------- */

#import "CAAnimation+CompletionBlock.h"
#import <objc/runtime.h>

static char CAAnimationCompletionBlockKey;

/* ----------------------------------------------------------------------
 @implementation CAAnimation (CompletionBlock)
 ---------------------------------------------------------------------- */

@implementation CAAnimation (CompletionBlock)


- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished {
    if (self.completionBlock) {
        self.completionBlock(animation);
    }
}

- (CAAnimationCompletionBlock)completionBlock {
    return objc_getAssociatedObject(self, &CAAnimationCompletionBlockKey);
}

- (void)setCompletionBlock:(CAAnimationCompletionBlock)completionBlock {
    if (!completionBlock) {
        return;
    }
    
    self.delegate = self;
    
    return objc_setAssociatedObject(self, &CAAnimationCompletionBlockKey, completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
