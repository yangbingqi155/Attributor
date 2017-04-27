//
//  TextStatsViewController.m
//  Attributor
//
//  Created by yangbinqi on 17/4/26.
//  Copyright © 2017年 valor. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController()
@property (weak, nonatomic) IBOutlet UILabel *colorsCharacters;
@property (weak, nonatomic) IBOutlet UILabel *strokeCharacters;

@end

@implementation TextStatsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}
-(void)setTextToAnalysis:(NSAttributedString *) textToAnalysis{
    _textToAnalysis=textToAnalysis;
    if(self.view.window) [self updateUI];
}

-(void)updateUI{
    self.colorsCharacters.text=[ NSString stringWithFormat:@"%lu color characters",(unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.strokeCharacters.text=[NSString stringWithFormat:@"%lu stroke characters",(unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName]  length]];
    
}

-(NSAttributedString *)charactersWithAttribute:(NSString *)attributeName{
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc] init];
    int index=0;
    NSRange nsRange;
    while (index<[self.textToAnalysis length]) {
        id value=[self.textToAnalysis attribute:attributeName atIndex:index effectiveRange:&nsRange];
        if(value){
            [attributeString appendAttributedString:[self.textToAnalysis attributedSubstringFromRange:nsRange]];
            index=nsRange.location+nsRange.length;
        }
        else{
            index++;
        }
    }
    
    return attributeString;
}

@end
