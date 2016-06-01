//
//  AdjList.m
//  AdjList
//
//  Created by Baekjoon Choi on 5/30/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

// arr[i] = i와 연결되어있는 모든 정점이 저장되어 있어야 함
// 1차원 array의 1차원 array

// arr이 생긴 모양: [[], [], [], [], [], []]
// 1 -> 2 간선이 추가
// arr이 생긴 모양: [[], [2], [1], [], [], []]
// 2 -> 3 간선이 추가
// arr이 생긴 모양: [[], [2], [1, 3], [2], [], []]
/* arr이 생긴 모양:
 [
    [], 
    [2], 
    [1, 3], 
    [2], 
    [], 
    []
 ]
*/
#import "AdjList.h"
#import "Edge.h"

@interface AdjList ()

@property (readwrite) NSInteger vertex;
@property (strong) NSMutableArray *arr;

@end

@implementation AdjList

-(instancetype)initWithVertex:(NSInteger)vertex {
    self = [super init];
    if (self) {
        self.vertex = vertex;
        self.arr = [NSMutableArray arrayWithCapacity:vertex+1];
        for (NSInteger i = 0; i < vertex+1; i++) {
            [self.arr addObject:[NSMutableArray array]];
        }
    }
    return self;
}

// 간선을 추가했으면 YES, 못했으면 NO
-(BOOL)addEdgeWithFrom:(NSInteger)from andTo:(NSInteger)to {
    // 1 ~ self.vertex 범위 안에 들어가는지 검사
    if (from <= 0 || self.vertex < from) return NO;
    if (to <= 0 || self.vertex < to) return NO;
    
    // [self.arr[from] addObject:@(to)];
    
    Edge *e = [[Edge alloc] initWithFrom:from andTo:to];
    [self.arr[from] addObject:e];
    
    return YES;
}

-(BOOL)addEdgeWithFrom:(NSInteger)from andTo:(NSInteger)to andCost:(NSInteger)cost {
    // 1 ~ self.vertex 범위 안에 들어가는지 검사
    if (from <= 0 || self.vertex < from) return NO;
    if (to <= 0 || self.vertex < to) return NO;
    
    // [self.arr[from] addObject:@(to)];
    
    Edge *e = [[Edge alloc] initWithFrom:from andTo:to andCost:cost];
    [self.arr[from] addObject:e];
    
    return YES;
}

-(BOOL)addEdgeWithFrom:(NSInteger)from andTo:(NSInteger)to andBidirection:(BOOL)bidirection {
    if (bidirection) {
        return [self addEdgeWithFrom:from andTo:to] && [self addEdgeWithFrom:to andTo:from];
    } else {
        return [self addEdgeWithFrom:from andTo:to];
    }
}

-(BOOL)addEdgeWithFrom:(NSInteger)from andTo:(NSInteger)to andCost:(NSInteger)cost andBidirection:(BOOL)bidirection {
    if (bidirection) {
        return [self addEdgeWithFrom:from andTo:to andCost:cost] && [self addEdgeWithFrom:to andTo:from andCost:cost];
    } else {
        return [self addEdgeWithFrom:from andTo:to andCost:cost];
    }
}

// A[1]: 2 3 5 7
-(void)printList {
    for (NSInteger i = 1; i <= self.vertex; i++) {
        NSMutableString *s = [NSMutableString string];
        [s appendFormat:@"arr[%zd]:", i];
        for (Edge *e in self.arr[i]) {
            [s appendFormat:@" (%zd,%zd)", e.to, e.cost];
        }
        NSLog(@"%@",s);
    }
}

-(void)sortList {
    for (NSInteger i = 1; i <= self.vertex; i++) {
        [self.arr[i] sortUsingSelector:@selector(compare:)];
        // NSArray인 경우에는 아래
        // self.arr[i] = [self.arr[i] sortedArrayUsingSelector:@selector(compare:)];
        /*
        [self.arr[i] sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            //지금 순서가 obj1 앞에, obj2 뒤에
            
            NSNumber *number1 = (NSNumber *)obj1;
            NSNumber *number2 = (NSNumber *)obj2;
            
            NSInteger n1 = [number1 integerValue];
            NSInteger n2 = [number2 integerValue];
         
            if (n1 < n2) { // 내림차순인 경우에는 n1 > n2
                return NSOrderedAscending;
            } else if (n1 == n2) {
                return NSOrderedSame;
            } else { // n1 > n2
                return NSOrderedDescending;
            }
            
        }];*/
    }
}

-(id)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.arr[idx];
}

@end
