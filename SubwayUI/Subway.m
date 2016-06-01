//
//  Subway.m
//  AdjList
//
//  Created by Baekjoon Choi on 6/1/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

#import "Subway.h"
#import "Graph.h"
#import "AdjList.h"

@interface Subway ()

@property (strong) NSMutableArray *stationList; // 정수 -> 역 이름
@property (strong) NSMutableDictionary *stationDict; // 역 이름 -> 정수
@property (strong) NSMutableArray *durationList;
@end

@implementation Subway

-(instancetype)init {
    self = [super init];
    if (self) {
        self.stationList = [NSMutableArray array];
        self.stationDict = [NSMutableDictionary dictionary];
        self.durationList = [NSMutableArray array];
        [self loadStation];
    }
    return self;
}

-(void)loadStation {
    NSArray *arr = @[@[@"대화",@(0)], @[@"주엽",@(1400)], @[@"정발산",@(1600)], @[@"마두",@(900)], @[@"백석",@(1400)], @[@"대곡",@(2500)], @[@"화정",@(2100)], @[@"원당",@(2600)], @[@"원흥",@(2900)], @[@"삼송",@(2100)], @[@"지축",@(1700)], @[@"구파발",@(1500)], @[@"연신내",@(2000)], @[@"불광",@(1300)], @[@"녹번",@(1100)], @[@"홍제",@(1600)], @[@"무악재",@(900)], @[@"독립문",@(1100)], @[@"경복궁(정부서울청사)",@(1600)], @[@"안국",@(1100)], @[@"종로3가",@(1000)], @[@"을지로3가",@(600)], @[@"충무로",@(700)], @[@"동대입구",@(900)], @[@"약수",@(700)], @[@"금호",@(800)], @[@"옥수",@(800)], @[@"압구정",@(2100)], @[@"신사",@(1500)], @[@"잠원",@(900)], @[@"고속터미널",@(1200)], @[@"교대(법원·검찰청)",@(1600)], @[@"남부터미널(예술의전당)",@(900)], @[@"양재(서초구청)",@(1800)], @[@"매봉",@(1200)], @[@"도곡",@(800)], @[@"대치",@(800)], @[@"학여울",@(800)], @[@"대청",@(900)], @[@"일원",@(1200)], @[@"수서",@(1800)], @[@"가락시장",@(1400)], @[@"경찰병원",@(800)], @[@"오금",@(800)]];
    for (NSArray *temp in arr) {
        [self.stationList addObject:temp[0]];
        [self.durationList addObject:temp[1]];
    }
    for (NSUInteger i = 0; i < self.stationList.count; i++) {
        self.stationDict[self.stationList[i]] = @(i+1);
    }
    // arr -> statioList와 stationDict
}

// [self nameToIndex:@"정발산"] -> 3
-(NSInteger)nameToIndex:(NSString *)stationName {
    return [self.stationDict[stationName] integerValue];
}

// [self indexToName:3] -> @"정발산"
-(NSString *)indexToName:(NSInteger)index {
    return self.stationList[index-1];
}

-(NSInteger)stations {
    return self.stationList.count;
}

-(void)addEdgeToGraph:(Graph *)graph {
    for (NSUInteger i = 0; i < self.stationList.count - 1; i++) {
        NSString *fromStation = self.stationList[i];
        NSString *toStation = self.stationList[i+1];
        NSInteger fromNumber = [self nameToIndex:fromStation];
        NSInteger toNumber = [self nameToIndex:toStation];
        // fromStation <-> toStation 양방향 Edge
        // fromNum <-> toNumber 양방향 Edge
        [graph.adj addEdgeWithFrom:fromNumber andTo:toNumber andCost:[self.durationList[i+1] integerValue] andBidirection:YES];
    }
}

@end
