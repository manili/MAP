//
//  CVariableTable.cpp
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Modified by MANili Inc. on 5/17/2014.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#include "CVariableTable.h"

int CVariableTable::intValue(CString line) {
    CString value = "";
    for (int i = 0; i < strlen(line.value()); i++) {
        if ((line.value()[i] >= '0' && line.value()[i] <= '9') && line.value()[i - 1] != 'R') {
            value = value + line.value()[i];
            if (line.value()[i + 1] == ' ') {
                break;
            }
        }
    }
    
    int len = value.len();
    if (len == 0)
        return 0;
    
    char temp[len];
    strcpy(temp, value.value());
    for (int i = len - 1; i >= 0; i--) {
        temp[(len -1) - i] = value.value()[i];
    }
    return CString::toInt(temp);
}

CString CVariableTable::stringValue(CString line, bool isLabel) {
    CString temp = "";
    char *lineTemp = line.value();
    if (isLabel) {
        for (int i = 0, started = false;
             (i < line.len() && lineTemp[i] != ',' && lineTemp[i] != ' ') || started == false;
             i++) {
            
            if (((lineTemp[i] >= 'a' && lineTemp[i] <= 'z')||(lineTemp[i] >= 'A' && lineTemp[i] <= 'Z')) ||
                (lineTemp[i] >= '0' && lineTemp[i] <= '9')) {
                started = true;
                temp = temp + lineTemp[i];
            }
            
        }
    }
    else {
        for (int i = 0, started = false;
             (i < line.len() && lineTemp[i] != ' ') || started == false;
             i++) {
            
            if (((lineTemp[i] >= 'a' && lineTemp[i] <= 'z')||(lineTemp[i] >= 'A' && lineTemp[i] <= 'Z')) ||
                (lineTemp[i] >= '0' && lineTemp[i] <= '9')) {
                started = true;
                temp = temp + lineTemp[i];
            }
            
        }
    }
    return temp;
}

void CVariableTable::passI(int &locationCounter, CString line) {
    if (line.findText("ORG")) {
        locationCounter = intValue(line) - 1;
    }
    else if (line.findText(",")) {
        CString temp = stringValue(line, true);
        if (symbolTable.changeValueOfKey(temp, locationCounter) == false)
            symbolTable.addDictionary(temp, locationCounter, true);
    } else if (line.findText("//")) {
        locationCounter--;
    }
}

void CVariableTable::generateTable() {
    CFile file(programPath,
               programName + ".msrc", "", "");
    CString sourceFileLine = file.readLineFromSourceFile();
    int locationCounter = 0;
    while (sourceFileLine != END_OF_FILE) {
        passI(locationCounter, sourceFileLine);
        sourceFileLine = file.readLineFromSourceFile();
        locationCounter++;
    }
}



















