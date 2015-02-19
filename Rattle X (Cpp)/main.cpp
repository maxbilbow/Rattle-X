//
//  main.cpp
//  X
//
//  Created by Max Bilbow on 21/12/2014.
//  Copyright (c) 2014 Rattle Media Ltd. All rights reserved.
//

#include <iostream>
#include <stdlib.h>
#include <cstdlib>
#include "Header.h"


const std::string PATH = "'/Volumes/RattleApps/sh/'"; //Users/rattle/Library/Mobile Documents/com~apple~CloudDocs/Rattle Apps/RattleApps/RattleApps 0.2.0/X/X/'";
const std::string SCRIPT = "rattle.sh";


int main(int argc, const char * argv[]) {
  
    Script x = *new Script();
    
    x.setCommand("cd "+PATH+" && ls && sh rattle.sh");
    x.execute();
    
   // std::cout << "Running: " << x.execute() << std::endl;
    //x.execute();
     // myfile.sh should be chmod +x
    return 0;
}
