//
//  RichTextViewController.m
//  TextKitDemo
//
//  Created by minjie on 13-10-25.
//  Copyright (c) 2013年 minjie. All rights reserved.
//

#import "RichTextViewController.h"
#import "MyTextStorage.h"

@interface RichTextViewController ()
@property (nonatomic,strong) UITextView* textView;
@property (nonatomic,strong) MyTextStorage* myTextStorage;
@end

@implementation RichTextViewController

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
    self.myTextStorage = [[MyTextStorage alloc] init];
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX)];
    container.widthTracksTextView = YES;
    [layoutManager addTextContainer:container];
    [self.myTextStorage addLayoutManager:layoutManager];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:container];
    self.textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.textView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    self.textView.scrollEnabled = YES;
    self.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.textView];
    
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/"] stringByAppendingString:@"book.txt"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:content];
    
    
    self.myTextStorage.tokens = @{ @"的" : @{ NSForegroundColorAttributeName : [UIColor redColor] },
                                 @"de" : @{ NSForegroundColorAttributeName : [UIColor blueColor] },
                                 DefaultTokenName : @{ NSForegroundColorAttributeName : [UIColor blackColor] } };
    
    [self.myTextStorage beginEditing];
    [self.myTextStorage setAttributedString:attrString];
    [self.myTextStorage endEditing];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
