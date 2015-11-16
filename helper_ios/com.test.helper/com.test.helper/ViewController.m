//
//  ViewController.m
//  com.test.helper
//
//  Created by billnie on 11/16/15.
//  Copyright © 2015 billnie. All rights reserved.
//

#import "ViewController.h"
#import <helper_ios/helper_ios.h>
#import <helper_ios/CircularProgressBar.h>

@interface ViewController ()
{
    IBOutlet UIView *_view1;
    IBOutlet ASValueTrackingSlider *_slider1;
    IBOutlet CircularProgressBar *_progressBar;
}
@end

@implementation ViewController
//-(void)loadView{
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    _view1.left =0;
    _view1.top = 0;
    CGPoint sz = CGPointMake(200, 400);
    [_view1 setCenter:sz];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * -0.5);
 //   _slider1.transform = trans;
    
    _slider1.maximumValue = 100.0f;
    _slider1.popUpViewCornerRadius = 0.0;
    [_slider1 setMaxFractionDigitsDisplayed:0];
    _slider1.popUpViewColor = [UIColor whiteColor];
    _slider1.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    _slider1.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    _slider1.popUpViewWidthPaddingFactor = 1.7;
    
    [_slider1 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _slider1.value = 5.0f;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            _view1.left = 0;
            _progressBar.size = CGSizeMake(100, 100);
        });
    });
    
    _progressBar.updateBlock = ^(NSString *str, int end){
        NSLog(str);
    };
    [_progressBar setTotalSecondTime:100];
    [_progressBar startTimer];
}


- (void) sliderValueChanged:(UISlider *)sender{
    CGPoint sz = CGPointMake(200+sender.value, 400);
    _view1.left = sender.value;
//    [_view1 setCenter:sz];
//    if(iPower == floor(sender.value))
//    {
//        return;
//    }
//    
//    iPower = floor(sender.value);
//    
//    for(int ii = 0; ii < sizeof(buttonState); ii++)
//    {
//        if(buttonState[ii])
//        {
//            [self bleRunFunctionWithTag:ii + 1];
//        }
//    }
    
    
}
//-(void) viewWillLayoutSubviews{
//    _view1.left = 0;
//}
//
//-(void) viewDidLayoutSubviews{
//    _view1.left = 0;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
