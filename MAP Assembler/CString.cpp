//
//  CString.cpp
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#include <math.h>
#include "CString.h"

int CString::toInt(char *value) {
    int temp = 0;
    for (long i = 0; value[i] != '\0'; i++) {
        temp += (value[i] - '0')*pow(10, i);
    }
    return temp;
}

char * CString::toString(int number) {
    CString temp = "";
    int digit = 0;
    int tempNum = number;
    while (tempNum /= 10) {
        digit++;
    }
    
    for (int i = digit; i >= 0; i--) {
        temp = temp + (number/(pow(10, i)) + '0');
        number %= (int)pow(10, i);
    }
    return temp.value();
}

int CString::len() {
    return (int)strlen(stringInit);
}

int CString::findText(char *stringToFind) {
    for (int i = 0; i < strlen(stringInit); i++) {
        bool found = true;
        for (int j = 0; j < strlen(stringToFind); j++) {
            if (stringToFind[j] != stringInit[i+j]) {
                found = false;
                break;
            }
        }
        if (found == true) {
            return i + 1;
        }
    }
    return false;
}

int CString::findText(const char *stringToFind) {
    for (int i = 0; i < strlen(stringInit); i++) {
        bool found = true;
        for (int j = 0; j < strlen(stringToFind); j++) {
            if (stringToFind[j] != stringInit[i+j]) {
                found = false;
                break;
            }
        }
        if (found == true) {
            return i + 1;
        }
    }
    return false;
}

bool CString::replace(char *replaceText, char *withText) {
    int fromPlace = findText(replaceText) - 1;
    if (fromPlace != -1) {
        CString temp = "";
        CString temp2 = "";
        for (int i = 0; i < fromPlace; i++) {
            temp = temp + stringInit[i];
        }
        for (int i = fromPlace + (int)strlen(replaceText); i < strlen(stringInit); i++) {
            temp2 = temp2 + stringInit[i];
        }
        temp = temp + withText;
        temp = temp + temp2.value();
        this -> operator=(temp.value());
    }
    
    return fromPlace + 1;
}

void CString::print() {
    for (int i = 0; i < strlen(stringInit); i++) {
        printf("%c", this -> value()[i]);
    }
}

void CString::deleteCurrentChar() {
    
}

char * CString::getStringFromIndexWithCount(int start, int count) {
    char *temp = new char[count]();
    for (int i = start; i < count; i++) {
        temp[i - start] = stringInit[i];
    }
    return temp;
}

char * CString::value() {
    if (stringInit != nullptr) {
        propertyStringInit = new char[strlen(stringInit)]();
        for (int i = 0; i < strlen(stringInit); i++) {
            propertyStringInit[i] = 0;
        }
        strcpy(propertyStringInit, stringInit);
        return propertyStringInit;
    }
    return nullptr;
}

char * CString::operator+ (char charToAppend) {
    long len = strlen(stringInit) + 1;
    char *stringTemp = new char[len]();
    strcpy(stringTemp, stringInit);
    stringTemp[len - 1] = charToAppend;
    stringTemp[len] = '\0';
    return stringTemp;
}

char * CString::operator+(char *stringToAppend) {
    long length = strlen(stringToAppend);
    length += strlen(stringInit);
    char *stringTemp = new char[length]();
    strcpy(stringTemp, stringInit);
    strcat(stringTemp, stringToAppend);
    return stringTemp;
}

char * CString::operator+(const char *stringToAppend) {
    long length = strlen(stringToAppend);
    length += strlen(stringInit);
    char *stringTemp = new char[length]();
    strcpy(stringTemp, stringInit);
    strcat(stringTemp, stringToAppend);
    return stringTemp;
}

char * CString::operator=(char charToAssign) {
    char *stringTemp = new char[2]();
    stringTemp[0] = charToAssign;
    stringTemp[1] = '\0';
    return stringTemp;
}

char * CString::operator=(char *stringToAssign) {
    char *stringTemp = new char[strlen(stringToAssign)]();
    strcpy(stringTemp, stringToAssign);
    stringInit = new char[strlen(stringTemp)]();
    strcat(stringInit, stringTemp);
    delete [] stringTemp;
    return stringInit;
}

char * CString::operator=(const char *stringToAssign) {
    if (stringInit != nullptr)
        delete [] stringInit;
    stringInit = new char[strlen(stringToAssign)]();
    strcat(stringInit, stringToAssign);
    return stringInit;
}

bool CString::operator== (char *stringToCompare) {
    return !(strcmp(this -> value(), stringToCompare));
}

bool CString::operator== (const char *stringToCompare) {
    return !(strcmp(this -> value(), stringToCompare));
}

bool CString::operator!= (char *stringToCompare) {
    return strcmp(this -> value(), stringToCompare);
}

bool CString::operator!= (const char *stringToCompare) {
    return strcmp(this -> value(), stringToCompare);
}




