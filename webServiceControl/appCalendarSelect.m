//
//  appCalendarSelect.m
//  myPota
//
//  Created by Rodrigo Pimentel on 22/05/14.
//  Copyright (c) 2014 web. All rights reserved.
//

#import "appCalendarSelect.h"

@implementation appCalendarSelect

@synthesize selected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        selected = NO;
        startCellX = -1;
        startCellY = -1;
        endCellX = -1;
        endCellY = -1;
        
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:.3f];
        
        UICollectionViewLayout *layout = [UICollectionViewLayout new];
        calendar = [[calendarControll alloc]initWithFrame:frame collectionViewLayout:layout];
    
        [self addSubview:calendar];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    if(selected) {
        //open area color
        CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceRGB();
        CGContextRef    context     = UIGraphicsGetCurrentContext();
        //shadow
        CGColorRef backgroundShadow           = [UIColor blackColor].CGColor;
        CGSize     backgroundShadowOffset     = CGSizeMake(2, 3);
        //round form
        CGFloat    backgroundShadowBlurRadius = 5;
        //borda
        UIColor* darkColor = [UIColor colorWithRed: .3 green: .3 blue: .75 alpha: 0.72];
        //centro
        UIColor* color  = [UIColor colorWithRed: 0.0 green: 0.08 blue: 0.84 alpha: 0.86];
        UIColor* color2 = [UIColor colorWithRed: 0.0 green: 0.02 blue: 0.64 alpha: 0.88];
        //efeito
        NSArray* gradient3Colors = [NSArray arrayWithObjects: (id)color.CGColor, (id)color2.CGColor, nil];
        CGFloat gradient3Locations[] = {0, 1};
        CGGradientRef gradient3 = CGGradientCreateWithColors( colorSpace, (CFArrayRef)gradient3Colors, gradient3Locations);
        
        int tempStart = MIN(startCellY, endCellY);
        int tempEnd   = MAX(startCellY, endCellY);
        
        for(int i = tempStart; i <= tempEnd; i++) {
            //// selectedRect Drawing
            int thisRowEndCell;
            int thisRowStartCell;
            if(startCellY == i) {
                thisRowStartCell = startCellX;
                if (startCellY > endCellY) {
                    thisRowStartCell = 0; thisRowEndCell = startCellX;
                }
            } else {
                thisRowStartCell = 0;
            }
            
            if(endCellY == i) {
                thisRowEndCell = endCellX;
                
                if (startCellY > endCellY) {
                    thisRowStartCell = endCellX; thisRowEndCell = 6;
                }
            } else if (!(startCellY > endCellY)) {
                thisRowEndCell = 6;
            }
            
            //create boarder mask
            CGFloat cornerRadius = 10.0;
            UIBezierPath* selectedRectPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(MIN(thisRowStartCell, thisRowEndCell) * COLLECTION_CELL_SIZE_X,
                                                                                                i * COLLECTION_CELL_SIZE_Y + COLLECTION_CELL_SIZE_Y/2,
                                                                                                (ABS(thisRowEndCell-thisRowStartCell)) * COLLECTION_CELL_SIZE_X + COLLECTION_CELL_SIZE_X,
                                                                                                COLLECTION_CELL_SIZE_Y/2)
                                                                        cornerRadius: cornerRadius];
            CGContextSaveGState(context);
            //create content
            [selectedRectPath addClip];
            CGContextDrawLinearGradient (context, gradient3, CGPointMake((MIN(thisRowStartCell, thisRowEndCell)+.5)*COLLECTION_CELL_SIZE_X, (i+1)*COLLECTION_CELL_SIZE_Y),
                                         CGPointMake((MIN(thisRowStartCell, thisRowEndCell)+.5)*COLLECTION_CELL_SIZE_X, i*COLLECTION_CELL_SIZE_Y), 0);
            CGContextRestoreGState(context);
            //create border line
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, backgroundShadowOffset, backgroundShadowBlurRadius, backgroundShadow);
            [darkColor setStroke];
            selectedRectPath.lineWidth = .5f;
            [selectedRectPath stroke];
            CGContextRestoreGState(context);
        }
        //close area color
        CGGradientRelease(gradient3);
        CGColorSpaceRelease(colorSpace);
    }
}

- (BOOL) selected
{
    return selected;
}

- (void) singleSelection:(NSSet *)touches
{
    self.selected = YES;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    startCellX = MIN((int)(point.x)/COLLECTION_CELL_SIZE_X,6);
    startCellY = (int)(point.y)/COLLECTION_CELL_SIZE_Y;
    
    endCellX = MIN(startCellX,6);
    endCellY = startCellY;
    
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self singleSelection:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    if(CGRectContainsPoint(self.bounds, point)) {
        endCellX = MIN((int)(point.x)/COLLECTION_CELL_SIZE_X,6);
        endCellY = (int)(point.y)/COLLECTION_CELL_SIZE_Y;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    if(CGRectContainsPoint(self.bounds, point))
    {
        endCellX = MIN((int)(point.x)/COLLECTION_CELL_SIZE_X,6);
        endCellY = (int)(point.y)/COLLECTION_CELL_SIZE_Y;
        [self setNeedsDisplay];
    }
}

@end
