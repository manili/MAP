//
//  CString.h
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#ifndef __ManoAssembler__CString__
#define __ManoAssembler__CString__

#include <iostream>

#endif /* defined(__ManoAssembler__CString__) */

class CString {
    
    char *stringInit;
    char *propertyStringInit;
    
public:
    
    CString() {
        
    }
    
    CString(char *stringInit) {
        propertyStringInit = nullptr;
        if (stringInit != nullptr) {
            this -> stringInit = new char[strlen(stringInit)]();
            strcpy(this -> stringInit, stringInit);
        }
    }
    
    CString(const char *stringInit) {
        propertyStringInit = nullptr;
        this -> stringInit = new char[strlen(stringInit)]();
        strcpy(this -> stringInit, stringInit);
    }
    
    ~CString() {
        
    }
    
    static int toInt(char *);
    static char * toString(int);
    int len();
    int findText(char *);
    int findText(const char *);
    bool replace(char *, char*);
    void print();
    void deleteCurrentChar();
    char * getStringFromIndexWithCount(int, int);
    char * value();
    char * operator+(char);
    char * operator+(char *);
    char * operator+(const char *);
    char * operator=(char);
    char * operator=(char *);
    char * operator=(const char *);
    bool operator==(char *);
    bool operator==(const char *);
    bool operator!=(char *);
    bool operator!=(const char *);
};