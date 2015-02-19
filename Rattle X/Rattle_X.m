//
//  Rattle_X.m
//  Rattle X
//
//  Created by Max Bilbow on 07/02/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#import "Rattle_X.h"

@implementation Rattle_X

- (void)mainViewDidLoad
{
    printf("Hello, World!");
}


- (void)doAThing
{
    
}
@end

@implementation RattleX

    NSString * PATH = @"'/Volumes/Rattle X/root/Library/Application Support/Rattle X/'";
    NSString * localPath = @"'Rattle X/'"; //Users/rattle/Library/Mobile Documents/com~apple~CloudDocs/Rattle Apps/RattleApps/RattleApps 0.2.0/X/X/'"
    NSString * SCRIPT = @"install.sh";
    ScriptExecuter *x;
    
    
    - (void)run
{
    x = [[ScriptExecuter alloc]init];
   
    [x setCommand:[NSString stringWithFormat:@"cd %@ && sh %@",PATH,SCRIPT]];
    
       // x.setCommand("cd \(PATH) && sh \(SCRIPT)")
       // x.execute()
    [x execute];
    
}
@end

