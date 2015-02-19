//
//  Rattle_X.h
//  Rattle X
//
//  Created by Max Bilbow on 07/02/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>
#import <stdlib.h>
#import <stdio.h>
#import <string.h>
#import <stddef.h>

//@property(nonatomic, copy) id string

@interface Rattle_X : NSPreferencePane

- (void)mainViewDidLoad;

@end

@interface RattleX : NSObject

- (void)run;

@end

@interface ScriptExecuter : NSObject

- (instancetype)init;
- (void)setCommand;
@end


@implementation ScriptExecuter

NSString * path = @"~/";
NSString * cmd = @"echo ";
NSString * script = @"rattle.sh";
NSString * command = @"";

- (instancetype)init
{
    return self;
}
    
- (void)setCommand:(NSString *)cmd
{
    self.command = cmd;
}
    
- (void)setCommand
{
//        command = cmd + path + script
}
    
- (void)setPath:(NSString *)path
{
    self.path = path;
}
    
- (void)setScript:(NSString *)script
{
    self.script = script;
}
    
-(void)setCmd:(NSString *)cmd
{
    self.cmd = cmd;
}

-(NSString *)execute
{
    
    const char * c = [command UTF8String];
    
    system(c);
    return command;//"\n Command Run: \n\(self.command)"
}
    

@end

