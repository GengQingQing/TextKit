//
//  HomeViewController.m
//  TextKitDemo
//
//  Created by minjie on 13-10-24.
//  Copyright (c) 2013年 minjie. All rights reserved.
//

#import "HomeViewController.h"
#import "DynamicFontSizeViewController.h"
#import "ExclusionPathViewController.h"
#import "RichTextViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Home";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dynamicFontSize:(id)sender
{
    DynamicFontSizeViewController* viewController = [[DynamicFontSizeViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)exclusionPath:(id)sender
{
    ExclusionPathViewController* viewController = [[ExclusionPathViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)richText:(id)sender
{
    RichTextViewController* viewController = [[RichTextViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
