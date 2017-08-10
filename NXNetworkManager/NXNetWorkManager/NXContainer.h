//
//  NXContainer.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXNetWorkProtol.h"
@interface NXContainer : NSObject<NXContainerProtol>

- (void) addInteger:(NSInteger) i forKey:(NSString *)key;
- (void) addDouble:(double)     d forKey:(NSString *)key;
- (void) addString:(NSString *) s forKey:(NSString *)key;

@end
