//
//  DataBase.h
//  FMDB_USING_DEMO
//
//  Created by matt on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;
@class Card;


@interface DataBase : NSObject

@property(nonatomic,strong) Person *person;

+ (instancetype)sharedDataBase;



#pragma mark - Person
/**
 *  添加person
 *
 */
- (void)addPerson:(Person *)person;
/**
 *  删除person
 *
 */
- (void)deletePerson:(Person *)person;
/**
 *  更新person
 *
 */
- (void)updatePerson:(Person *)person;

/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllPerson;

#pragma mark - Card


/**
 *  给person添加卡
 *
 */
- (void)addCard:(Card *)Card toPerson:(Person *)person;
/**
 *  给person删除卡
 *
 */
- (void)deleteCard:(Card *)Card fromPerson:(Person *)person;
/**
 *  获取person的所有卡
 *
 */
- (NSMutableArray *)getAllCardsFromPerson:(Person *)person;
/**
 *  删除person的所有卡
 *
 */
- (void)deleteAllCardsFromPerson:(Person *)person;



@end


