//
//  Graph.h
//  AdjList
//
//  Created by Baekjoon Choi on 5/30/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AdjList;

@interface Graph : NSObject

@property (strong) AdjList *adj;

-(instancetype)initWithVertex:(NSInteger)vertex;
-(void)loadDemoData1;
-(void)loadDemoData2;
-(void)loadDemoData3;
-(void)dfsWithStart:(NSInteger)start;
-(void)bfsWithStart:(NSInteger)start; // start에서 모든 역까지 가는 방법
-(NSArray *)bfsWithStart:(NSInteger)start andEnd:(NSInteger)end; // start -> end 가는 방법
-(BOOL)checkBipartiteGraph;
-(NSInteger)countConnectedComponents;
@end
