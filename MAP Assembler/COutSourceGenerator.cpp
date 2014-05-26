//
//  CBinaryGenerator.cpp
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Modified by MANili Inc. on 5/17/2014.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#include "COutSourceGenerator.h"

void COutSourceGenerator::replaceSymbolWithAddress() {
    CString *symbolKey = new CString[symbolValues.getDicLen()]();
    for (int i = 0; i < symbolValues.getDicLen(); i++) {
        symbolKey[i] = symbolValues.allKeys()[i].value();
    }
    
    CString sourceFileLine = file -> readLineFromSourceFile();
    while (sourceFileLine != END_OF_FILE) {
        if (sourceFileLine.findText("//")) {
            sourceFileLine = file -> readLineFromSourceFile();
            continue;
        }
        for (int i = 0; i < symbolValues.getDicLen(); i++) {
            
            if (sourceFileLine.findText(",") && symbolValues.isDicLabel(symbolKey[i].value())) {
                CString nullVal = "\0";
                CString labelToDelete = symbolKey[i];
                labelToDelete = labelToDelete + ", ";
                sourceFileLine.replace(labelToDelete.value(), nullVal.value());
            }
            
            CString tempStringToSearch = " ";
            tempStringToSearch = tempStringToSearch + symbolKey[i].value();
            tempStringToSearch = tempStringToSearch + "\n";
            
            CString stringToReplace = " ";
            stringToReplace = stringToReplace + CString::toString(symbolValues.valueForKey(symbolKey[i]));
            stringToReplace = stringToReplace + "\n";
            
            sourceFileLine.replace(tempStringToSearch.value(), stringToReplace.value());
        }
        file -> writeLineToOutSourceFile(sourceFileLine);
        sourceFileLine = "";
        sourceFileLine = file -> readLineFromSourceFile();
    }
    delete [] symbolKey;
}
    
    
    
    
    
    
    
