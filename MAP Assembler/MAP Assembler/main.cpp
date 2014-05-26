//
//  main.cpp
//  MAP Assembler
//
//  Created by MANili Inc. on 5/17/14.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#include <iostream>
#include "CExecutableFileGenerator.h"

using namespace std;

int findCurrentPath(const char *argv) {
    long len = strlen(argv);
    long addrLen = len;
    for (long i = len - 1; argv[i] != '/' && i != -1; i--) {
        addrLen --;
    }
    return (int)addrLen;
}

int main(int argc, const char * argv[])
{
    //Find current directory
    int lastIndex = findCurrentPath(*argv);
    char System_Files_Path[200] = {0};
    char tempArgv[strlen(*argv)];
    char tempPath[lastIndex];
    
    //Initial System_File_Path for instruction table
    strcpy(tempArgv, *argv);
    tempArgv[lastIndex - 1] = '\0';
    strcpy(tempPath, tempArgv);
    strcpy(System_Files_Path, tempPath);
    
    //Find source code directory
    char programPath[200] = {0};
    char programName[50] = {0};
    char programNameTemp[50] = {0};
    
    programName[0] = '/';
    
    cout << "Enter source PATH :\n(Example : /Users/Some_User/Desktop)\n";
    cin >> programPath;
    cout << "Enter source NAME :\n(Example : Test)\n";
    cin >> programNameTemp;
    
    strcat(programName, programNameTemp);
    
    //Start assembling :
    CExecutableFileGenerator efg(programPath, programName, "/INS.mtbl", System_Files_Path);
    
    return 0;
}

