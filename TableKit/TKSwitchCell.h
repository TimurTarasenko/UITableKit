//
//  TKSwitchCell.h
//
//  Created by Sergey Nikitenko on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKCell.h"

@class TKSwitchCell;
@protocol TKSwitchCellDelegate <NSObject>
@optional
-(void)switchCell:(TKSwitchCell*)cell didSwitchState:(BOOL)state;
@end


@interface TKSwitchCell : TKCell
{
    NSString* title;
    BOOL state;
	id<TKSwitchCellDelegate> delegate;
}

+(TKSwitchCell*) cellWithTitle:(NSString*)title state:(BOOL)state;
-(id) initWithTitle:(NSString*)title state:(BOOL)state;

@property (nonatomic, assign) id<TKSwitchCellDelegate> delegate;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, assign) BOOL state;

@end
