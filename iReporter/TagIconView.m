//
//  Tagiconview   instead of photoview. use it to view tag icons
//  iReporter
//
//  Created by Fahim Farook on 9/6/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "TagIconView.h"
#import "API.h"

@implementation TagIconView

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithIndex:(int)i andData:(NSDictionary*)data {
    self = [super init];
    if (self !=nil) {
        //initialize
        self.tag = [[data objectForKey:@"tagID"] intValue];
      //  NSLog(@"%d",self.tag);
        int row = i/2;
        int col = i % 2;
        self.frame = CGRectMake(1.5*kPadding+col*(kThumbSide+kPadding), 1.5*kPadding+row*(kThumbSide+kPadding), kThumbSide, kThumbSide);
        self.backgroundColor = [UIColor whiteColor];
        //add the photo caption
        UILabel* caption = [[UILabel alloc] initWithFrame:CGRectMake(0, kThumbSide-32, kThumbSide, 32)];
        caption.backgroundColor = [UIColor blackColor];
        caption.textColor = [UIColor whiteColor];
        caption.textAlignment = UITextAlignmentCenter;
        caption.numberOfLines =2;
        caption.alpha = 0.5f;
        caption.font = [UIFont systemFontOfSize:12];
        caption.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"tagName"]];
        [self addSubview: caption];
		//add touch event
		[self addTarget:delegate action:@selector(didSelectPhoto:) forControlEvents:UIControlEventTouchUpInside];
		//load the image
		API* api = [API sharedInstance];
		int tagID = [[data objectForKey:@"tagID"] intValue];
		NSURL* imageURL = [api urlForTagIcon:[NSNumber numberWithInt: tagID]];
        //NSLog(@"%@",imageURL);
		AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL] success:^(UIImage *image) {
			//create an image view, add it to the view
			UIImageView* thumbView = [[UIImageView alloc] initWithImage: image];
            thumbView.frame = CGRectMake(0,0,kThumbSide,kThumbSide);
            //thumbView.contentMode = UIViewContentModeScaleAspectFit;
            thumbView.contentMode = UIViewContentModeCenter;
			[self insertSubview: thumbView belowSubview: caption];
		}];
		NSOperationQueue* queue = [[NSOperationQueue alloc] init];
		[queue addOperation:imageOperation];
    }
    return self;
}

@end
