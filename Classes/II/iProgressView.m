//
//  iProgressView.m
//  MakeMoney
//
#import "iProgressView.h"
#define kPad 3
#define kSize 183

@implementation iProgressView

- (id)initWithFrame:(CGRect)frame {
	return [self initWithFrame:frame text:nil];
}

- (id)initWithFrame:(CGRect)frame text:(NSString*)t{
	CGRect r = CGRectMake(frame.size.width/2-kSize/2, frame.size.height/2-kSize/2, kSize, kSize);
	
    if (self = [super initWithFrame:r]) {
		strokeColor = [UIColor clearColor];
		fillColor = [UIColor blackColor];
		textColor = [UIColor whiteColor];
		
		text = [[UILabel alloc] initWithFrame:CGRectMake(kPad, kPad, r.size.width-kPad, 44)];
		text.font = [UIFont boldSystemFontOfSize:19];
		text.textColor = textColor;
		text.textAlignment = UITextAlignmentCenter;
		text.backgroundColor = [UIColor clearColor];
		if (t)
			text.text = t;
		[self addSubview:text];
		progress = [[UIProgressView alloc] initWithFrame:CGRectMake(22.0, 44.0, r.size.width - 44.0, 22.0)];
		[self addSubview:progress];
		progress.hidden = YES;
		indica = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		indica.center = CGPointMake(r.size.width/2,r.size.height/2+5); //CGRectMake(r.size.width/2-20,r.size.height/2, 40, 40);
		indica.hidden = NO;
		[indica startAnimating];
		[self addSubview:indica];
		[self setBackgroundColor: [UIColor clearColor]];
		[self setAlpha:0.83];
    }
    return self;
}

- (void)layout:(CGRect)rect
{
	CGRect r = CGRectMake(rect.size.width/2-kSize/2, rect.size.height/2-kSize/2, kSize, kSize);
	self.frame = r;
	[text setFrame:CGRectMake(kPad, kPad, r.size.width-kPad, 44)];
	[progress setFrame:CGRectMake(22.0, 44.0, r.size.width - 44.0, 22.0)];
	indica.center = CGPointMake(r.size.width/2,r.size.height/2+5); 	
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	CGContextClearRect(context, rect); 
	CGContextSetLineWidth(context, 3.0f);
	//CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	//CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); 	
	//CGRect drawrect = CGRectMake(touch1.x, touch1.y, touch2.x - touch1.x, touch2.y - touch1.y);
	CGContextSetFillColorWithColor(context, fillColor.CGColor);
	CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
	CGRect drawrect = rect;
	CGFloat radius = 13.0;	
	CGFloat minx = CGRectGetMinX(drawrect), midx = CGRectGetMidX(drawrect), maxx = CGRectGetMaxX(drawrect);
	CGFloat miny = CGRectGetMinY(drawrect), midy = CGRectGetMidY(drawrect), maxy = CGRectGetMaxY(drawrect);	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);

	/*
	CGRect b = rect;
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat w = b.size.width;
	CGFloat h = b.size.height;
	CGFloat pad = 2;
	
	CGContextBeginPath (context);
	CGContextMoveToPoint(context,0, 0);
	CGContextAddLineToPoint(context, w, 0);
	CGContextAddLineToPoint(context, w,h);
	CGContextAddLineToPoint(context, 0, h);
	CGContextClosePath (context);
	
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextDrawPath(context, kCGPathFill);
	CGContextFillPath(context);
	
	CGContextBeginPath (context);
	CGContextMoveToPoint(context, pad, 4*pad);
	CGContextAddArcToPoint(context, pad, pad, 4*pad, pad, 20);
	CGContextAddLineToPoint(context, w-4*pad, pad);
	CGContextAddArcToPoint(context, w-pad, pad, w-pad, 4*pad, 20);
	
	CGContextAddLineToPoint(context, w-pad,h-pad);
	CGContextAddLineToPoint(context, pad, h-pad);
	
	CGContextClosePath (context);
	
	CGContextSetFillColorWithColor(context, [UIColor viewFlipsideBackgroundColor].CGColor);
	CGContextDrawPath(context, kCGPathFill);
	CGContextFillPath(context);
*/
}

- (void)setFill:(UIColor*)c 
{
	fillColor = c;
}

- (void)setStroke:(UIColor*)c 
{
	strokeColor = c;
}

- (void)setTextColor:(UIColor*)c 
{
	textColor = c;
	text.textColor = textColor;
}


- (void)dealloc {
	[progress release];
    [super dealloc];
}

#pragma mark progressing
//hide progress if p<=0, else progress
- (void)setProgress:(float)p 
{
	if (p<=0) {
		[progress setHidden:YES];		
	} else {
		[progress setHidden:NO];
		[progress setProgress:p];		
	}
}

- (void)setText:(NSString*)t 
{
	text.text = t;
}

@end
