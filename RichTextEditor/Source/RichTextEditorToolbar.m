//
//  RichTextEditorToolbar.m
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditorToolbar.h"

#define ITEM_SEPARATOR_SPACE 5
#define ITEM_TOP_AND_BOTTOM_BORDER 5
#define ITEM_WITH 40

@interface RichTextEditorToolbar()
@property (nonatomic, strong) id <RichTextEditorPopover> popover;
@property (nonatomic, strong) RichTextEditorToggleButton *btnBold;
@property (nonatomic, strong) RichTextEditorToggleButton *btnItalic;
@property (nonatomic, strong) RichTextEditorToggleButton *btnUnderline;
@property (nonatomic, strong) RichTextEditorToggleButton *btnFontSize;
@property (nonatomic, strong) RichTextEditorToggleButton *btnFont;
@property (nonatomic, strong) RichTextEditorToggleButton *btnBackgroundColor;
@property (nonatomic, strong) RichTextEditorToggleButton *btnForegroundColor;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentLeft;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentCenter;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentRight;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentJustified;
@end

@implementation RichTextEditorToolbar

#pragma mark - Initialization -

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		self.backgroundColor = [UIColor lightGrayColor];
		
		self.btnFont = [self buttonWithStyle:RichTextEditorToggleButtonStyleNormal
								  imageNamed:@"dropDownTriangle.png"
										width:120
								 andSelector:@selector(fontSelected:)];
		[self.btnFont setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
		[self.btnFont setTitle:@"Font" forState:UIControlStateNormal];
		
		
		self.btnFontSize = [self buttonWithStyle:RichTextEditorToggleButtonStyleNormal
									  imageNamed:@"dropDownTriangle.png"
											width:50
									 andSelector:@selector(fontSizeSelected:)];
		[self.btnFontSize setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
		[self.btnFontSize setTitle:@"14" forState:UIControlStateNormal];
		
		self.btnBold = [self buttonWithStyle:RichTextEditorToggleButtonStyleLeft
								  imageNamed:@"bold.png"
								 andSelector:@selector(boldSelected:)];
		
		
		self.btnItalic = [self buttonWithStyle:RichTextEditorToggleButtonStyleCenter
									imageNamed:@"italic.png"
								   andSelector:@selector(italicSelected:)];
		
		
		self.btnUnderline = [self buttonWithStyle:RichTextEditorToggleButtonStyleRight
									   imageNamed:@"underline.png"
									  andSelector:@selector(underLineSelected:)];
		
		
		self.btnTextAlignmentLeft = [self buttonWithStyle:RichTextEditorToggleButtonStyleLeft
											   imageNamed:@"justifyleft.png"
											  andSelector:@selector(textAlignmentSelected:)];
		
		
		self.btnTextAlignmentCenter = [self buttonWithStyle:RichTextEditorToggleButtonStyleCenter
												 imageNamed:@"justifycenter.png"
												andSelector:@selector(textAlignmentSelected:)];
		
		
		self.btnTextAlignmentRight = [self buttonWithStyle:RichTextEditorToggleButtonStyleCenter
												imageNamed:@"justifyright.png"
											   andSelector:@selector(textAlignmentSelected:)];
		
		self.btnTextAlignmentJustified = [self buttonWithStyle:RichTextEditorToggleButtonStyleRight
													imageNamed:@"justifyfull.png"
												   andSelector:@selector(textAlignmentSelected:)];
		
		self.btnForegroundColor = [self buttonWithStyle:RichTextEditorToggleButtonStyleNormal
											 imageNamed:@"forecolor.png"
											andSelector:@selector(textForegroundColorSelected:)];
		
		self.btnBackgroundColor = [self buttonWithStyle:RichTextEditorToggleButtonStyleNormal
											 imageNamed:@"backcolor.png"
											andSelector:@selector(textBackgroundColorSelected:)];
		
		[self addView:self.btnFont afterView:nil withSpacing:YES];
		[self addView:self.btnFontSize afterView:self.btnFont withSpacing:YES];
		[self addView:self.btnBold afterView:self.btnFontSize withSpacing:YES];
		[self addView:self.btnItalic afterView:self.btnBold withSpacing:NO];
		[self addView:self.btnUnderline afterView:self.btnItalic withSpacing:NO];
		[self addView:self.btnTextAlignmentLeft afterView:self.self.btnUnderline withSpacing:YES];
		[self addView:self.btnTextAlignmentCenter afterView:self.self.btnTextAlignmentLeft withSpacing:NO];
		[self addView:self.btnTextAlignmentRight afterView:self.self.btnTextAlignmentCenter withSpacing:NO];
		[self addView:self.btnTextAlignmentJustified afterView:self.self.btnTextAlignmentRight withSpacing:NO];
		[self addView:self.btnForegroundColor afterView:self.self.btnTextAlignmentJustified withSpacing:YES];
		[self addView:self.btnBackgroundColor afterView:self.self.btnForegroundColor withSpacing:YES];
	}
	
	return self;
}

#pragma mark - Public Methods -

- (void)updateStateWithAttributes:(NSDictionary *)attributes
{
	UIFont *font = [attributes objectForKey:NSFontAttributeName];
	NSParagraphStyle *paragraphTyle = [attributes objectForKey:NSParagraphStyleAttributeName];
	
	[self.btnFontSize setTitle:[NSString stringWithFormat:@"%.f", font.pointSize] forState:UIControlStateNormal];
	[self.btnFont setTitle:font.familyName forState:UIControlStateNormal];
	
	self.btnBold.on = [font isBold];
	self.btnItalic.on = [font isItalic];
	
	self.btnTextAlignmentLeft.on = NO;
	self.btnTextAlignmentCenter.on = NO;
	self.btnTextAlignmentRight.on = NO;
	self.btnTextAlignmentJustified.on = NO;
	
	switch (paragraphTyle.alignment)
	{
		case NSTextAlignmentLeft:
			self.btnTextAlignmentLeft.on = YES;
			break;
		case NSTextAlignmentCenter:
			self.btnTextAlignmentCenter.on = YES;
			break;
			
		case NSTextAlignmentRight:
			self.btnTextAlignmentRight.on = YES;
			break;
			
		case NSTextAlignmentJustified:
			self.btnTextAlignmentJustified.on = YES;
			break;
			
		default:
			self.btnTextAlignmentLeft.on = YES;
			break;
	}
	
	NSNumber *existingUnderlineStyle = [attributes objectForKey:NSUnderlineStyleAttributeName];
	self.btnUnderline.on = (!existingUnderlineStyle || existingUnderlineStyle.intValue == NSUnderlineStyleNone) ? NO :YES;
}

#pragma mark - IBActions -

- (void)boldSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectBold];
}

- (void)italicSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectItalic];
}

- (void)underLineSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectUnderline];
}

- (void)fontSizeSelected:(UIButton *)sender
{
	RichTextEditorFontSizePickerViewController *fontSizePicker = [[RichTextEditorFontSizePickerViewController alloc] init];
	fontSizePicker.fontSizes = [self.dataSource fontSizeSelectionForRichTextEditorToolbar];
	fontSizePicker.delegate = self;
	[self presentPopoverWithViewController:fontSizePicker fromView:sender];
}

- (void)fontSelected:(UIButton *)sender
{
	RichTextEditorFontPickerViewController *fontPicker= [[RichTextEditorFontPickerViewController alloc] init];
	fontPicker.fontNames = [self.dataSource fontFamilySelectionForichTextEditorToolbar];
	fontPicker.delegate = self;
	[self presentPopoverWithViewController:fontPicker fromView:sender];
}

- (void)textBackgroundColorSelected:(UIButton *)sender
{
	RichTextEditorColorPickerViewController *colorPicker = [[RichTextEditorColorPickerViewController alloc] init];
	colorPicker.action = RichTextEditorColorPickerActionTextBackgroundColor;
	colorPicker.delegate = self;
	[self presentPopoverWithViewController:colorPicker fromView:sender];
}

- (void)textForegroundColorSelected:(UIButton *)sender
{
	RichTextEditorColorPickerViewController *colorPicker = [[RichTextEditorColorPickerViewController alloc] init];
	colorPicker.action = RichTextEditorColorPickerActionTextForegroudColor;
	colorPicker.delegate = self;
	[self presentPopoverWithViewController:colorPicker fromView:sender];
}

- (void)textAlignmentSelected:(UIButton *)sender
{
	NSTextAlignment textAlignment;
	
	if (sender == self.btnTextAlignmentLeft)
		textAlignment = NSTextAlignmentLeft;
	else if (sender == self.btnTextAlignmentCenter)
		textAlignment = NSTextAlignmentCenter;
	else if (sender == self.btnTextAlignmentRight)
		textAlignment = NSTextAlignmentRight;
	else if (sender == self.btnTextAlignmentJustified)
		textAlignment = NSTextAlignmentJustified;
	
	[self.delegate richTextEditorToolbarDidSelectTextAlignment:textAlignment];
}

#pragma mark - Private Methods -

- (RichTextEditorToggleButton *)buttonWithStyle:(RichTextEditorToggleButtonStyle)style imageNamed:(NSString *)image width:(NSInteger)width andSelector:(SEL)selector
{
	RichTextEditorToggleButton *button = [[RichTextEditorToggleButton alloc] initWithStyle:style];
	[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(0, 0, width, 0)];
	[button.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
	[button.titleLabel setTextColor:[UIColor blackColor]];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
	
	return button;
}

- (RichTextEditorToggleButton *)buttonWithStyle:(RichTextEditorToggleButtonStyle)style imageNamed:(NSString *)image andSelector:(SEL)selector
{
	return [self buttonWithStyle:style imageNamed:image width:ITEM_WITH andSelector:selector];
}

- (void)addView:(UIView *)view afterView:(UIView *)otherView withSpacing:(BOOL)space
{
	CGRect otherViewRect = (otherView) ? otherView.frame : CGRectZero;
	CGRect rect = view.frame;
	rect.origin.x = otherViewRect.size.width + otherViewRect.origin.x;
	if (space)
		rect.origin.x += ITEM_SEPARATOR_SPACE;
	
	rect.origin.y = ITEM_TOP_AND_BOTTOM_BORDER;
	rect.size.height = self.frame.size.height - (2*ITEM_TOP_AND_BOTTOM_BORDER);
	view.frame = rect;
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	[self addSubview:view];
	[self updateContentSize];
}

- (void)updateContentSize
{
	NSInteger maxViewlocation = 0;
	
	for (UIView *view in self.subviews)
	{
		NSInteger endLocation = view.frame.size.width + view.frame.origin.x;
		
		if (endLocation > maxViewlocation)
			maxViewlocation = endLocation;
	}
	
	self.contentSize = CGSizeMake(maxViewlocation+ITEM_SEPARATOR_SPACE, self.frame.size.height);
}

- (void)presentPopoverWithViewController:(UIViewController *)viewController fromView:(UIView *)view
{
	id <RichTextEditorPopover> popover = [self popoverWithViewController:viewController];
	[popover presentPopoverFromRect:view.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (id <RichTextEditorPopover>)popoverWithViewController:(UIViewController *)viewController
{
	id <RichTextEditorPopover> popover;
	
	if (!popover)
	{
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			popover = (id<RichTextEditorPopover>) [[UIPopoverController alloc] initWithContentViewController:viewController];
		}
		else
		{
			popover = (id<RichTextEditorPopover>) [[WEPopoverController alloc] initWithContentViewController:viewController];
		}
	}
	
	[self.popover dismissPopoverAnimated:YES];
	self.popover = popover;
	
	return popover;
}

#pragma mark - RichTextEditorColorPickerViewControllerDelegate Methods -

- (void)richTextEditorColorPickerViewControllerDidSelectColor:(UIColor *)color withAction:(RichTextEditorColorPickerAction)action
{
	if (action == RichTextEditorColorPickerActionTextBackgroundColor)
	{
		[self.delegate richTextEditorToolbarDidSelectTextBackgroundColor:color];
	}
	else
	{
		[self.delegate richTextEditorToolbarDidSelectTextForegroundColor:color];
	}
	
	[self.popover dismissPopoverAnimated:YES];
}

- (void)richTextEditorColorPickerViewControllerDidSelectClose
{
	[self.popover dismissPopoverAnimated:YES];
}

#pragma mark - RichTextEditorFontSizePickerViewControllerDelegate Methods -

- (void)richTextEditorFontSizePickerViewControllerDidSelectFontSize:(NSNumber *)fontSize
{
	[self.delegate richTextEditorToolbarDidSelectFontSize:fontSize];
	[self.popover dismissPopoverAnimated:YES];
}

#pragma mark - RichTextEditorFontPickerViewControllerDelegate Methods -

- (void)richTextEditorFontPickerViewControllerDidSelectFonteWithNam:(NSString *)fontName
{
	[self.delegate richTextEditorToolbarDidSelectFontWithName:fontName];
	[self.popover dismissPopoverAnimated:YES];
}

@end
