# FMDB_USING_DEMO

通过 FMDB 实现在iOS端搭建本地数据库，并实现表与表之间的关联的一个 demo ，demo的主要功能是 给某人的账户添加 银行卡

实现：
1.分别创建了两个表，第一个表，用来存储个人信息；第二个表用来存储银行卡信息，demo写的过于简单，希望能给需要的人提供帮助
2.创建两个模型类接收表中的数据，和后期对表中的数据进行编辑
3.封装工具类，将FMDB中增删改查方法进行封装
4.在需要使用数据库的地方调用

具体请看demo
 
```
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
```
