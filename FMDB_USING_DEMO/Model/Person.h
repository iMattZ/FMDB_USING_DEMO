//
//  Person.h
//  FMDB_USING_DEMO
//
//  Created by matt on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,strong) NSNumber *ID;


@property(nonatomic,copy) NSString *name;

@property(nonatomic,assign) NSInteger age;

@property(nonatomic,assign) NSInteger number;
/**
 *  一个人可以拥有多张卡
 */
@property(nonatomic,strong) NSMutableArray *cardArray;

@end

NS_ASSUME_NONNULL_END
