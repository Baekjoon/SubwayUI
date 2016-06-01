//
//  NSMutableArray+Queue.h
//  Queue
//
//  Created by Baekjoon Choi on 5/30/16.
//  Copyright © 2016 Startlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Queue)

-(void)push:(id)obj;
-(id)pop;
-(BOOL)empty;

@end
