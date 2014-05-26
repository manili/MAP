//
//  CDictionary.h
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#ifndef __ManoAssembler__CDictionary__
#define __ManoAssembler__CDictionary__

#include <iostream>
#include "CFile.h"

#endif /* defined(__ManoAssembler__CDictionary__) */

class Dictionary {
    
public:
    
    bool isLabel;
    CString key;
    int value;
    
    Dictionary() {
        this -> isLabel = false;
    }
    
    Dictionary operator=(Dictionary dicToAssign) {
        this -> key = dicToAssign.key;
        this -> value = dicToAssign.value;
        this -> isLabel = dicToAssign.isLabel;
        return *this;
    }
};

class CDictionary {
    
    Dictionary *dictArray;
    int dictArrayLen;
    
public:
    
    void printKey() {
        for (int i = 0; i < dictArrayLen; i++) {
            printf("%s %d %d\n", dictArray[i].key.value(), dictArray[i].value, dictArray[i].isLabel);
        }
        printf("\n");
    }
    
    CDictionary() {
        dictArray = nullptr;
        dictArrayLen = 0;
    }
    
    ~CDictionary() {
        
    }
    
    void addDictionary(CString, int, bool isLabel = false);
    bool changeValueOfKey(CString, int);
    bool isDicLabel(CString);
    int valueForKey(CString);
    int getDicLen();
    CString * allKeys();
    
    void operator=(CDictionary);
};