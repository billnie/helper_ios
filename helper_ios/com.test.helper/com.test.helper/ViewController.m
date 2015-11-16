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
#import <helper_ios/TileView.h>

#define kTileWidth  60.f
#define kTileHeight kTileWidth
#define kTileMarginLeft1 25.f
#define kTileMarginLeft2 (320.f - kTileMarginLeft1 - kTileWidth)
#define kTileMargin 10.f

@interface ViewController ()
{
    IBOutlet UIView *_view1;
    IBOutlet ASValueTrackingSlider *_slider1;
    IBOutlet CircularProgressBar *_progressBar;
    // 拖动的tile的原始center坐标
    CGPoint _dragFromPoint;
    
    // 要把tile拖往的center坐标
    CGPoint _dragToPoint;
    
    // tile拖往的rect
    CGRect _dragToFrame;
    
    // 拖拽的tile是否被其他tile包含
    BOOL _isDragTileContainedInOtherTile;
    
    // 拖拽往的目标处的tile
    TileView *_pushedTile;
}

@property (nonatomic, readonly) NSMutableArray *tileArray;
@end

@implementation ViewController
@synthesize tileArray = _tileArray;
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
    
    TileView *tv;
    tv = [self addViewButtonTouch];
    tv.labTitle.text = @"标题";
    
    tv = [self addViewButtonTouch];
    tv.labTitle.text = @"标题2";
    tv = [self addViewButtonTouch];
    tv.labTitle.text = @"标题3";
    tv = [self addViewButtonTouch];
    tv.labTitle.text = @"标题4";
    
}
#pragma mark - 控件点击

- (TileView*)addViewButtonTouch
{
    TileView *view = [[TileView alloc] initWithTarget:self action:@selector(dragTile:)];
    
    view.frame = [self createFrameLayoutTile];
    

    [self.view addSubview:view];
    [self.tileArray addObject:view];
    
//    [self scrollToBottomWithScrollView:self.scrollView];
    return view;
}

- (CGRect)createFrameLayoutTile
{
    int counter = self.tileArray.count;
    
    int marginTop = (kTileHeight + kTileMargin) * (counter / 4 +0)+_slider1.bottom + 10;//- 80;
    int row, col;
    row = counter/4;
    col = counter%4;
    int left;
    left = ([UIScreen mainScreen].applicationFrame.size.width - 4*3 - kTileWidth*4)/2;
    return CGRectMake(left+col *(kTileWidth+4), marginTop, kTileWidth, kTileHeight);
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
#pragma mark - 手势操作

- (BOOL)dragTile:(UIPanGestureRecognizer *)recognizer
{
    switch ([recognizer state])
    {
        case UIGestureRecognizerStateBegan:
            [self dragTileBegan:recognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragTileMoved:recognizer];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragTileEnded:recognizer];
            break;
        default: break;
    }
    return YES;
}

- (void)dragTileBegan:(UIPanGestureRecognizer *)recognizer
{
    _dragFromPoint = recognizer.view.center;
    [UIView animateWithDuration:0.2f animations:^{
        recognizer.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
        recognizer.view.alpha = 0.8;
    }];
}

- (void)dragTileMoved:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    [self rollbackPushedTileIfNecessaryWithPoint:recognizer.view.center];
    [self pushedTileMoveToDragFromPointIfNecessaryWithTileView:(TileView *)recognizer.view];
}

- (void)rollbackPushedTileIfNecessaryWithPoint:(CGPoint)point
{
    if (_pushedTile && !CGRectContainsPoint(_dragToFrame, point))
    {
        [UIView animateWithDuration:0.2f animations:^{
            _pushedTile.center = _dragToPoint;
        }];
        
        _dragToPoint = _dragFromPoint;
        _pushedTile = nil;
        _isDragTileContainedInOtherTile = NO;
    }
}

- (void)pushedTileMoveToDragFromPointIfNecessaryWithTileView:(TileView *)tileView
{
    for (TileView *item in self.tileArray)
    {
        if (CGRectContainsPoint(item.frame, tileView.center) && item != tileView)
        {
            _dragToPoint = item.center;
            _dragToFrame = item.frame;
            _pushedTile = item;
            _isDragTileContainedInOtherTile = YES;
            
            [UIView animateWithDuration:0.2 animations:^{
                item.center = _dragFromPoint;
            }];
            break;
        }
    }
}

- (void)dragTileEnded:(UIPanGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.2f animations:^{
        recognizer.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
        recognizer.view.alpha = 1.f;
    }];
    
    [UIView animateWithDuration:0.2f animations:^{
        if (_isDragTileContainedInOtherTile)
            recognizer.view.center = _dragToPoint;
        else
            recognizer.view.center = _dragFromPoint;
    }];
    
    _pushedTile = nil;
    _isDragTileContainedInOtherTile = NO;
}

#pragma mark - getter

- (NSMutableArray *)tileArray
{
    if (!_tileArray)
    {
        _tileArray = [[NSMutableArray alloc] init];
    }
    return _tileArray;
}

@end
