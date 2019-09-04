//
//  CardViewController.m
//  FMDB_USING_DEMO
//
//  Created by 张博文 on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import "CardViewController.h"
#import "DataBase.h"
#import "Person.h"
#import "Card.h"
@interface CardViewController ()

@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *cardArray;

@end

@implementation CardViewController

- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"卡包";
    
    self.dataArray = [[DataBase sharedDataBase] getAllPerson];

    for (int i = 0 ; i < self.dataArray.count; i++) {
        Person *person = self.dataArray[i];
        NSMutableArray *carArray =  [[DataBase sharedDataBase] getAllCardsFromPerson:person];
        [self.cardArray addObject:carArray];
        
    }
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    Person *person = self.dataArray[section];
    label.text = [NSString stringWithFormat:@"%@ 的所有卡",person.name];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;

    return label;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *carArray = self.cardArray[section];
    return carArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carcell"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSMutableArray *cardArray = self.cardArray[indexPath.section];
    Card *card = cardArray[indexPath.row];
    
    cell.textLabel.text = card.brand;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"余额: % ld",card.price];
    
    return cell;
    
}
/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        NSMutableArray *cardArray = self.cardArray[indexPath.section];
        
        Card *card = cardArray[indexPath.row];
        
        Person *person = self.dataArray[indexPath.section];
        
        
        NSLog(@"car.id--%@,own_id--%@",card.card_id,card.owner_id);
        
        [[DataBase sharedDataBase] deleteCard:card fromPerson:person];
        
        
        
        
        self.dataArray = [[DataBase sharedDataBase] getAllPerson];
        
        self.cardArray = [[NSMutableArray alloc] init];
        
        for (int i = 0 ; i < self.dataArray.count; i++) {
            Person *person = self.dataArray[i];
            NSMutableArray *carArray =  [[DataBase sharedDataBase] getAllCardsFromPerson:person];
            [self.cardArray addObject:carArray];
            
        }
        
        
        
        [self.tableView reloadData];
        
        
    }
    
    
}


#pragma mark - Getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
    
}

- (NSMutableArray *)cardArray{
    if (!_cardArray) {
        _cardArray = [[NSMutableArray alloc ] init];
    }
    return _cardArray;
    
}



@end
