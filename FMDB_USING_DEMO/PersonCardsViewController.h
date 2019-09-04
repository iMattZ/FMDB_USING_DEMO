//
//  PersonCardsViewController.h
//  FMDB_USING_DEMO
//
//  Created by 张博文 on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
NS_ASSUME_NONNULL_BEGIN

@interface PersonCardsViewController : UITableViewController
@property(nonatomic,strong) Person *person;
@end

NS_ASSUME_NONNULL_END
