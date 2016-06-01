//
//  ViewController.m
//  SubwayUI
//
//  Created by Baekjoon Choi on 6/1/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

#import "ViewController.h"
#import "Subway.h"
#import "Graph.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () <UIScrollViewDelegate>

@property(strong) Subway *subway;
@property(strong) Graph *graph;
@property(strong) NSMutableDictionary *positions;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Subway *subway = [[Subway alloc] init];
    self.subway = subway;
    Graph *graph = [[Graph alloc] initWithVertex:subway.stations];
    self.graph = graph;
    [subway addEdgeToGraph:graph];
    
    [self.scrollView setZoomScale:0.2];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    recognizer.numberOfTapsRequired = 1;
    recognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:recognizer];
    
    // 신사 {1435.8324676813954, 1128.1942538851858}
    // 종로3가 {1223.2415265205777, 578.15737437386406}
    // 연신내 {797.49723430169149, 449.36550790342153}
    // 대화 {190.09454527078381, 445.42863862266563}

    self.positions = [NSMutableDictionary dictionaryWithCapacity:4];
    CGPoint p = CGPointMake(1435.8324676813954, 1128.1942538851858);
    self.positions[@"신사"] = [NSValue valueWithCGPoint:p];
    p = CGPointMake(1223.2415265205777, 578.15737437386406);
    self.positions[@"종로3가"] = [NSValue valueWithCGPoint:p];
    p = CGPointMake(797.49723430169149, 449.36550790342153);
    self.positions[@"연신내"] = [NSValue valueWithCGPoint:p];
    p = CGPointMake(190.09454527078381, 445.42863862266563);
    self.positions[@"대화"] = [NSValue valueWithCGPoint:p];
    p = CGPointMake(1439, 1088.5);
    self.positions[@"압구정"] = [NSValue valueWithCGPoint:p];
    
    p = CGPointMake(1435.5, 1048);
    self.positions[@"옥수"] = [NSValue valueWithCGPoint:p];
    
    p = CGPointMake(1436, 974);
    self.positions[@"금호"] = [NSValue valueWithCGPoint:p];
    
    p = CGPointMake(1436.5, 914.5);
    self.positions[@"약수"] = [NSValue valueWithCGPoint:p];
    
    p = CGPointMake(1361.5, 846.5);
    self.positions[@"동대입구"] = [NSValue valueWithCGPoint:p];
    
    p = CGPointMake(1327.5, 803.5);
    self.positions[@"충무로"] = [NSValue valueWithCGPoint:p];
    
    p = CGPointMake(1223, 706.5);
    self.positions[@"을지로3가"] = [NSValue valueWithCGPoint:p];
    
}


-(void)singleTapGestureCaptured:(UITapGestureRecognizer *)recognizer {
    CGPoint touchPoint = [recognizer locationInView:self.imageView];
    NSLog(@"%@",NSStringFromCGPoint(touchPoint));
    NSString *subwayName = @"";
    CGFloat distance = CGFLOAT_MAX;
    CGPoint stationPoint = CGPointZero;
    for (NSString *key in self.positions) {
        CGPoint p = [self.positions[key] CGPointValue];
        CGFloat dx = touchPoint.x - p.x;
        CGFloat dy = touchPoint.y - p.y;
        CGFloat d = sqrt(dx*dx + dy*dy);
        if (distance > d) {
            distance = d;
            subwayName = key;
            stationPoint = p;
        }
    }
    if (distance > 100) {
//        return;
    }
    NSLog(@"%@",subwayName);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    v.center = stationPoint;
    
    v.backgroundColor = [UIColor redColor];
    v.alpha = 0.5;
    v.layer.cornerRadius = 25.0;
    [self.imageView addSubview:v];
    
    [UIView animateWithDuration:1.0 animations:^{
        v.alpha = 0.0;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
    
    CGPoint convertedPoint = [self.imageView convertPoint:stationPoint toView:self.scrollView];
    convertedPoint.x -= self.scrollView.frame.size.width/2.0;
    convertedPoint.y -= self.scrollView.frame.size.height/2.0;
    [self.scrollView setContentOffset:convertedPoint animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
