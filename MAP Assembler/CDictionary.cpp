//
//  CDictionary.cpp
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#include "CDictionary.h"

void CDictionary::addDictionary(CString key, int value, bool isLabel) {
    Dictionary temp;
    temp.key = key;
    temp.value = value;
    if (isLabel) {
        temp.isLabel = true;
    }
    
    Dictionary *arrayDictTemp = new Dictionary[++dictArrayLen]();
    for (int i = 0; i < dictArrayLen - 1; i++) {
        arrayDictTemp[i] = dictArray[i];
    }
    
    arrayDictTemp[dictArrayLen - 1] = temp;
    
    if (dictArray != nullptr) {
        delete [] dictArray;
        dictArray = nullptr;
    }
    dictArray = arrayDictTemp;
    dictArray[dictArrayLen].isLabel = isLabel;
}

bool CDictionary::changeValueOfKey(CString key, int newValue) {
    bool isKeyExist = false;
    for (int i = 0; i < dictArrayLen; i++) {
        if (key == dictArray[i].key.value()) {
            dictArray[i].value = newValue;
            isKeyExist = true;
        }
    }
    return isKeyExist;
}

bool CDictionary::isDicLabel(CString key) {
    bool isLabel = false;
    for (int i = 0; i < dictArrayLen; i++) {
        if (key == dictArray[i].key.value() && dictArray[i].isLabel) {
            isLabel = true;
        }
    }
    return isLabel;
}

int CDictionary::valueForKey(CString key) {
    for (int i = 0; i < dictArrayLen; i++) {
        if (key == dictArray[i].key.value()) {
            return dictArray[i].value;
        }
    }
    return -1;
}

int CDictionary::getDicLen() {
    return dictArrayLen;
}

CString * CDictionary::allKeys() {
    CString *temp = new CString[dictArrayLen]();
    for (int i = 0; i < dictArrayLen; i++) {
        temp[i] = dictArray[i].key.value();
    }
    return temp;
}

void CDictionary::operator=(CDictionary dicToCopy) {
    Dictionary *temp = new Dictionary[dicToCopy.dictArrayLen]();
    for (int i = 0; i < dicToCopy.dictArrayLen; i++) {
        temp[i] = dicToCopy.dictArray[i];
    }
    dictArrayLen = dicToCopy.dictArrayLen;
    dictArray = temp;
}

















