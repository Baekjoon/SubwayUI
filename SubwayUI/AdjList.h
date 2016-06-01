//
//  AdjList.h
//  AdjList
//
//  Created by Baekjoon Choi on 5/30/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdjList : NSObject

-(instancetype)initWithVertex:(NSInteger)vertex;
// from -> to 간선을 추가 (bidirection == YES) 양방향
-(BOOL)addEdgeWithFrom:(NSInteger)from andTo:(NSInteger)to;
-(BOOL)addEdgeWithFrom:(NSInteger)from andTo:(NSInteger)to andBidirection:(BOOL)bidirection;
-(BOOL)addEdgeWithFrom:(NSInteger)from andTo:(NSInteger)to andCost:(NSInteger)cost andBidirection:(BOOL)bidirection;
-(void)printList; // 인접 리스트 출력
-(void)sortList; // 인접 리스트 정렬
// self[] 배열 표현식으로 클래스를 사용 가능
-(id)objectAtIndexedSubscript:(NSUInteger)idx;
@end
