//
//  Header.h
//  X
//
//  Created by Max Bilbow on 21/12/2014.
//  Copyright (c) 2014 Rattle Media Ltd. All rights reserved.
//

#ifndef X_Header_h
#define X_Header_h


#endif

class Script {
    std::string path;
    std::string cmd;
    std::string script;
    std::string command;
    
public: Script(){
    this->path = "~/";
    this->cmd = "echo ";
    this->script = "rattle.sh";
    this->command = (this->cmd + this->path + this->script);
}
    
public: bool setCommand (std::string cmd){
    this->command = cmd;
    return true;
}
    
public: bool setCommand (){
    this->command = (this->cmd + this->path + this->script);
    return true;
}
    
public: bool setPath(std::string path){
    this->path = path;
    return true;
}
    
public: bool setScript(std::string script){
    this->script = script;
    return true;
}
    
public: bool setCmd(std::string cmd){
    this->cmd = cmd;
    return true;
}
    
public: std::string execute(){
    std::system(this->command.c_str());
    return "\n Command Run: \n" + this->command;
}
    
    
public: bool execute(std::string s){
    std::system(s.c_str());
    return true;
}
    
    
    
};
