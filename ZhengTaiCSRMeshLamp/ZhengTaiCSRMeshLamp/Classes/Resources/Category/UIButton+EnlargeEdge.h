//
//  UIButton+EnlargeEdge.h
//  WIColorLamp
//
//  Created by lxz on 15/9/24.
//  Copyright © 2015年 chipsguide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
