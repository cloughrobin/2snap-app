

//
//  ArenaPhotoView.h
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
@protocol ArenaPhotoViewDelegate <NSObject>
-(void)didSelectArenaPhoto:(id)sender;
@end

//3 define the thumb view interface
@interface ArenaPhotoView : UIButton
@property (assign, nonatomic) id<ArenaPhotoViewDelegate> delegate;

-(id)initWithIndex:(int)i andData:(NSDictionary*)data;

@end
