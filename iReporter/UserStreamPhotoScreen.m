//
//  UsetStreamPhotoScreen.m
//  iReporter
//
//  Created by Arda Varilsuha on 12/19/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "UserStreamPhotoScreen.h"
#import "API.h"

@interface UserStreamPhotoScreen ()

@end

@implementation UserStreamPhotoScreen

@synthesize IdPhoto;

-(void)viewDidLoad {
	API* api = [API sharedInstance];
	//load the caption of the selected photo
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", IdPhoto,@"IdPhoto", nil] onCompletion:^(NSDictionary *json) {
		//show the text in the label
		NSArray* list = [json objectForKey:@"result"];
		NSDictionary* photo = [list objectAtIndex:0];
		lblTitle.text = [photo objectForKey:@"title"];
        //NSLog(@"%@",photo,[photo objectForKey:@"title"]);
	}];
    
	//load the big size photo
	NSURL* imageURL = [api urlForImageWithId:IdPhoto isThumb:NO];
	[photoView setImageWithURL: imageURL];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

@end