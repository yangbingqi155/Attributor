//
//  ViewController.m
//  Attributor
//
//  Created by yangbinqi on 17/4/20.
//  Copyright © 2017年 valor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *outlineButtonTitle=[[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [outlineButtonTitle addAttributes:@{
                                        NSStrokeWidthAttributeName:@3,
                                        NSStrokeColorAttributeName:self.outlineButton.tintColor
                                        } range:NSMakeRange(0, [outlineButtonTitle string].length)];
    [self.outlineButton setAttributedTitle:outlineButtonTitle forState:UIControlStateNormal];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeBodyFontSizeUsingPreferredFontSize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontSizeChanged:) name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}
-(void)preferredFontSizeChanged:(NSNotification *)notification
{
    [self changeBodyFontSizeUsingPreferredFontSize];
}
-(void)changeBodyFontSizeUsingPreferredFontSize{
    self.body.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}
- (IBAction)changeSelectedBodyFontColor:(UIButton *)sender{
    [self.body.textStorage addAttributes:@{NSForegroundColorAttributeName:sender.backgroundColor} range:self.body.selectedRange];
}

- (IBAction)changeSelectedBodyOutline:(UIButton *)sender {
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName:@-3,
                                            NSStrokeColorAttributeName:[UIColor blackColor] }
                                   range:self.body.selectedRange];
    
}
- (IBAction)changeSelectedBodyUnoutline:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSStrokeWidthAttributeName value:@0 range:self.body.selectedRange];
}


@end
