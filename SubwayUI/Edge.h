//
//  Edge.h
//  AdjList
//
//  Created by Baekjoon Choi on 6/1/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Edge : NSObject

@property (readwrite) NSInteger from;
@property (readwrite) NSInteger to;
@property (readwrite) NSInteger cost;

-(instancetype)initWithFrom:(NSInteger)from andTo:(NSInteger)to;
-(instancetype)initWithFrom:(NSInteger)from andTo:(NSInteger)to andCost:(NSInteger)cost;

@end
