//
//  PhotoView.h
//  iReporter
//
//  Created by Fahim Farook on 9/6/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

//1 layout config
#define kThumbSide 130
#define kPadding 10

//2 define the thumb delegate protocol
@protocol TagIconViewDelegate <NSObject>
-(void)didSelectPhoto:(id)sender;
@end

//3 define the thumb view interface
@interface TagIconView : UIButton
@property (assign, nonatomic) id<TagIconViewDelegate> delegate;

-(id)initWithIndex:(int)i andData:(NSDictionary*)data;

@end
