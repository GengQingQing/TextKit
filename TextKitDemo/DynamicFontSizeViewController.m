//
//  DynamicFontSizeViewController.m
//  TextKitDemo
//
//  Created by minjie on 13-10-24.
//  Copyright (c) 2013年 minjie. All rights reserved.
//

#import "DynamicFontSizeViewController.h"

@interface DynamicFontSizeViewController ()
@property (nonatomic,weak) IBOutlet UITextView* textView;
@end

@implementation DynamicFontSizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.textView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
//    UIFontTextStyleHeadline
//    UIFontTextStyleBody
//    UIFontTextStyleSubheadline
//    UIFontTextStyleFootnote
//    UIFontTextStyleCaption1
//    UIFontTextStyleCaption2
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/"] stringByAppendingString:@"book.txt"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = content;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preferredContentSizeChange:(NSNotification *)notification
{
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

@end
