//
//  ExclusionPathViewController.m
//  TextKitDemo
//
//  Created by minjie on 13-10-24.
//  Copyright (c) 2013年 minjie. All rights reserved.
//

#import "ExclusionPathViewController.h"

@interface ExclusionPathViewController ()
{
    CGPoint _panOffset;
}
@property (nonatomic,weak) IBOutlet UITextView* textView;
@property (nonatomic,weak) IBOutlet UIImageView* imageView;
@end

@implementation ExclusionPathViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/"] stringByAppendingString:@"book.txt"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = content;
    
    [self.imageView addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imagePan:)]];
	[self updateExclusionPaths];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePan:(UIPanGestureRecognizer *)pan
{
	// Capute offset in view on begin
	if (pan.state == UIGestureRecognizerStateBegan)
		_panOffset = [pan locationInView: self.imageView];
	
	// Update view location
	CGPoint location = [pan locationInView: self.view];
	CGPoint circleCenter = self.imageView.center;
	
	circleCenter.x = location.x - _panOffset.x + self.imageView.frame.size.width / 2;
	circleCenter.y = location.y - _panOffset.y + self.imageView.frame.size.width / 2;
	self.imageView.center = circleCenter;
	
	// Update exclusion path
	[self updateExclusionPaths];
}

- (void)updateExclusionPaths
{
	CGRect ovalFrame = [self.textView convertRect:self.imageView.bounds fromView:self.imageView];
	
	// Since text container does not know about the inset, we must shift the frame to container coordinates
	ovalFrame.origin.x -= self.textView.textContainerInset.left;
	ovalFrame.origin.y -= self.textView.textContainerInset.top;
	
	// Simply set the exclusion path
	UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect: ovalFrame];
	self.textView.textContainer.exclusionPaths = @[ovalPath];
}

@end
