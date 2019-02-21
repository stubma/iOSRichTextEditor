//
//  RichTextEditorColorPickerViewController.m
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/iOS-Rich-Text-Editor
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RichTextEditorColorPickerViewController.h"
#import "UIColor+RichTextEditor.h"
#import "RTEColorPickerView.h"

@interface RichTextEditorColorPickerViewController ()

@property (nonatomic, assign, readonly) UIColor* lastSelectedForegroundColor;
@property (nonatomic, assign, readonly) UIColor* lastSelectedBackgroundColor;
@property (nonatomic, strong) RTEColorPickerView* colorPickerView;

@end

@implementation RichTextEditorColorPickerViewController

#pragma mark - VoewController Methods -

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// load color picker view
	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	UINib* nib = [UINib nibWithNibName:@"RTEColorPicker" bundle:bundle];
	self.colorPickerView = [nib instantiateWithOwner:self options:nil][0];
	
	// add
	CGSize contentSize = CGSizeMake(self.view.frame.size.width, 100);
	[self.view addSubview:self.colorPickerView];
	self.colorPickerView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
	self.preferredContentSize = contentSize;
#else
	self.contentSizeForViewInPopover = contentSize;
#endif
}

- (UIColor*)lastSelectedForegroundColor {
	NSUserDefaults* d = [NSUserDefaults standardUserDefaults];
	NSString* cstr = [d stringForKey:@"RichTextEditor_foregroundColor"];
	if(!cstr || [cstr length] <= 0) {
		cstr = @"000000ff";
	}
	return [UIColor rte_colorWithHexString:cstr];
}

- (UIColor*)lastSelectedBackgroundColor {
	NSUserDefaults* d = [NSUserDefaults standardUserDefaults];
	NSString* cstr = [d stringForKey:@"RichTextEditor_backgroundColor"];
	if(!cstr || [cstr length] <= 0) {
		cstr = @"00000000";
	}
	return [UIColor rte_colorWithHexString:cstr];
}

#pragma mark - IBActions -

- (IBAction)doneSelected:(id)sender
{
	[self.delegate richTextEditorColorPickerViewControllerDidSelectColor:self.selectedColorView.backgroundColor withAction:self.action];
}

- (IBAction)closeSelected:(id)sender
{
	[self.delegate richTextEditorColorPickerViewControllerDidSelectClose];
}

@end

