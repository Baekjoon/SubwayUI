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

@property(strong) NSString *startStation;
@property(strong) NSString *endStation;

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
    if (self.startStation == nil) {
        self.startStation = subwayName;
    } else {
        self.endStation = subwayName;
    }
    NSLog(@"%@",subwayName);
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    v.center = stationPoint;
    
    if (self.startStation == subwayName) {
        v.backgroundColor = [UIColor redColor];
    } else {
        v.backgroundColor = [UIColor blueColor];
    }
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
    
    if (self.startStation != nil && self.endStation != nil) {
        [self startFindPath];
    }
}

-(void)startFindPath {
    NSString *start = self.startStation;
    NSInteger startNumber = [self.subway nameToIndex:start];
    NSString *end = self.endStation;
    NSInteger endNumber = [self.subway nameToIndex:end];
    NSArray *result = [self.graph bfsWithStart:startNumber andEnd:endNumber];
    NSArray *path = result[0];
    NSNumber *distance = result[1];
    NSMutableArray *pathWithName = [NSMutableArray array];
    for (NSNumber *num in path) {
        [pathWithName addObject:[self.subway indexToName:[num integerValue]]];
    }
    NSLog(@"%@",[pathWithName componentsJoinedByString:@" => "]);
    NSLog(@"%@m", distance);
    // 50km/h = 50000m/h => 833.33333333 m / min
    double d = [distance doubleValue];
    double minute = d / 800.0 + 0.4*([path count] - 1);
    NSLog(@"%.2lf분",minute);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ => %@", self.startStation, self.endStation] message:[NSString stringWithFormat:@"%.0lf분", minute] preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self drawLines:pathWithName];
        self.startStation = nil;
        self.endStation = nil;
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}

-(void)drawLines:(NSMutableArray *)paths {
    NSMutableArray *layersToRemove = [NSMutableArray array];
    for (id layer in self.imageView.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layersToRemove addObject:layer];
        }
    }
    for (id layer in layersToRemove) {
        [layer removeFromSuperlayer];
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint fromPoint = [self.positions[paths[0]] CGPointValue];
    [path moveToPoint:fromPoint];
    for (int i=1; i<(int)paths.count; i++) {
        NSString *to = paths[i];
        CGPoint toPoint = [self.positions[to] CGPointValue];
        [path addLineToPoint:toPoint];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor greenColor] CGColor];
    shapeLayer.lineWidth = 25.0;
    shapeLayer.cornerRadius = 5.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.imageView.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnimtation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimtation.duration = 1.0;
    pathAnimtation.fromValue = @(0.0);
    pathAnimtation.toValue = @(1.0);
    [shapeLayer addAnimation:pathAnimtation forKey:@"strokeEnd"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
