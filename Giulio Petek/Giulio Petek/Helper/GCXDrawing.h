/* ----------------------------------------------------------------------
 GCXDrawing.h
 
 Created by Gilo on 02.08.12.
 Copyright (c) 2012 Giulio Petek. All rights reserved.
 ---------------------------------------------------------------------- */

#define GCXSafeCurrentContextDrawing(block) { CGContextSaveGState(UIGraphicsGetCurrentContext()); block(); CGContextRestoreGState(UIGraphicsGetCurrentContext()); }
