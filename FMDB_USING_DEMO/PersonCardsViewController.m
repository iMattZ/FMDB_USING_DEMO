//
//  PersonCardsViewController.m
//  FMDB_USING_DEMO
//
//  Created by 张博文 on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import "PersonCardsViewController.h"
#import "Person.h"
#import "Card.h"
#import "DataBase.h"
@interface PersonCardsViewController ()
@property(nonatomic,strong) NSMutableArray *cardArray;
@end

@implementation PersonCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@的所有卡",self.person.name];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCard)];
    
    
    self.cardArray = [[DataBase sharedDataBase ] getAllCardsFromPerson:self.person];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cardArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personcarscell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"personcarscell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    Card *card = self.cardArray[indexPath.row];
    
    cell.textLabel.text = card.brand;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"余额: %ld " ,card.price];
    return cell;
    
    
}
/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        Card *card = self.cardArray[indexPath.row];
        
        NSLog(@"car.id--%@,own_id--%@",card.card_id,card.owner_id);
        [[DataBase sharedDataBase] deleteCard:card fromPerson:self.person];
        
        
        self.cardArray = [[DataBase sharedDataBase] getAllCardsFromPerson:self.person];
        
        [self.tableView reloadData];
        
        
    }
    
    
}

#pragma mark - Action
- (void)addCard{
    NSLog(@"添加车辆");
    
    
    
    Card *card = [[Card alloc] init];
    card.owner_id = self.person.ID;
    
    NSArray *brandArray = [NSArray arrayWithObjects:@"工商",@"农业",@"建设",@"中国",@"招商",@"浦发", nil];
    NSInteger index = arc4random_uniform((int)brandArray.count);
    card.brand = [brandArray objectAtIndex:index];
    
    card.price = arc4random_uniform(1000000);
    
    [[DataBase sharedDataBase] addCard:card toPerson:self.person];
    
    self.cardArray = [[DataBase sharedDataBase] getAllCardsFromPerson:self.person];
    
    
    
    [self.tableView reloadData];
    
    
    
    
}

#pragma mark - Getter
- (NSMutableArray *)carArray{
    if (!_cardArray) {
        _cardArray = [[NSMutableArray alloc] init];
    }
    return _cardArray;
    
}

@end
