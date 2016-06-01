//
//  Edge.m
//  AdjList
//
//  Created by Baekjoon Choi on 6/1/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

#import "Edge.h"

@implementation Edge

-(instancetype)initWithFrom:(NSInteger)from andTo:(NSInteger)to {
    self = [self initWithFrom:from andTo:to andCost:1];
    return self;
}

-(instancetype)initWithFrom:(NSInteger)from andTo:(NSInteger)to andCost:(NSInteger)cost {
    self = [super init];
    if (self) {
        self.from = from;
        self.to = to;
        self.cost = cost;
    }
    return self;
}

-(NSComparisonResult)compare:(Edge *)obj {
    if (self.to < obj.to) {
        return NSOrderedAscending;
    } else if (self.to == obj.to) {
        return NSOrderedSame;
    } else { // self.to > obj.to
        return NSOrderedDescending;
    }
}

@end
