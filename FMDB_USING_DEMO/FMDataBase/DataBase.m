//
//  DataBase.m
//  FMDB_USING_DEMO
//
//  Created by matt on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>
#import "Person.h"
#import "Card.h"
static DataBase *_instance = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}




@end

@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_instance == nil) {
        
        _instance = [[DataBase alloc] init];
        
        [_instance initDataBase];
        
    }
    
    return _instance;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_instance == nil) {
        
        _instance = [super allocWithZone:zone];
        
    }
    
    return _instance;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    NSString *personSql = @"CREATE TABLE 'person' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number'VARCHAR(255)) ";
    NSString *cardSql = @"CREATE TABLE 'card' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'own_id' VARCHAR(255),'card_id' VARCHAR(255),'card_brand' VARCHAR(255),'card_price'VARCHAR(255)) ";
    
    [_db executeUpdate:personSql];
    [_db executeUpdate:cardSql];
    
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addPerson:(Person *)person{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"person_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"person_id"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO person(person_id,person_name,person_age,person_number)VALUES(?,?,?,?)",maxID,person.name,@(person.age),@(person.number)];
    
    
    
    [_db close];
    
}

- (void)deletePerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE person_id = ?",person.ID];
    
    [_db close];
}

- (void)updatePerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"UPDATE 'person' SET person_name = ?  WHERE person_id = ? ",person.name,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_age = ?  WHERE person_id = ? ",@(person.age),person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_number = ?  WHERE person_id = ? ",@(person.number + 1),person.ID];
    
    
    
    [_db close];
}

- (NSMutableArray *)getAllPerson{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    
    while ([res next]) {
        Person *person = [[Person alloc] init];
        person.ID = @([[res stringForColumn:@"person_id"] integerValue]);
        person.name = [res stringForColumn:@"person_name"];
        person.age = [[res stringForColumn:@"person_age"] integerValue];
        person.number = [[res stringForColumn:@"person_number"] integerValue];
        
        [dataArray addObject:person];
        
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}
/**
 *  给person添加卡
 *
 */
- (void)addCard:(Card *)card toPerson:(Person *)person{
    [_db open];
    
    //根据person是否拥有card来添加car_id
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM card where own_id = %@ ",person.ID]];
    
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"card_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"card_id"] integerValue]);
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO card(own_id,card_id,card_brand,card_price)VALUES(?,?,?,?)",person.ID,maxID,card.brand,@(card.price)];
    
    
    
    [_db close];
    
}
/**
 *  给person删除卡
 *
 */
- (void)deleteCard:(Card *)card fromPerson:(Person *)person{
    [_db open];
    
    
    [_db executeUpdate:@"DELETE FROM card WHERE own_id = ?  and card_id = ? ",person.ID,card.card_id];
    
    
    [_db close];
    
    
    
}
/**
 *  获取person的所有卡
 *
 */
- (NSMutableArray *)getAllCardsFromPerson:(Person *)person{
    
    [_db open];
    NSMutableArray  *cardArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM card where own_id = %@",person.ID]];
    while ([res next]) {
        Card *card = [[Card alloc] init];
        card.owner_id = person.ID;
        card.card_id = @([[res stringForColumn:@"card_id"] integerValue]);
        card.brand = [res stringForColumn:@"card_brand"];
        card.price = [[res stringForColumn:@"card_price"] integerValue];
        
        [cardArray addObject:card];
        
    }
    [_db close];
    
    return cardArray;
    
}
- (void)deleteAllCardsFromPerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM card WHERE own_id = ?",person.ID];
    
    
    [_db close];
}


@end
