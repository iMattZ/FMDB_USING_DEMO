//
//  Card.h
//  FMDB_USING_DEMO
//
//  Created by matt on 2019/9/4.
//  Copyright © 2019 com.hime. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject
/**
 *  所有者
 */
@property(nonatomic,strong ) NSNumber *owner_id;

/**
 *  卡的ID
 */
@property(nonatomic,strong) NSNumber *card_id;


@property(nonatomic,  copy) NSString *brand;
@property(nonatomic,assign) NSInteger price;
@end

NS_ASSUME_NONNULL_END
