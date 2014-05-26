//
//  CBinaryGenerator.h
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Modified by MANili Inc. on 5/17/2014.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#ifndef __ManoAssembler__CBinaryGenerator__
#define __ManoAssembler__CBinaryGenerator__

#include <iostream>
#include "CVariableTable.h"

#endif /* defined(__ManoAssembler__CBinaryGenerator__) */

class COutSourceGenerator {
    
    CFile *file;
    CDictionary symbolValues;
    
    void replaceSymbolWithAddress();
    
public:
    
    COutSourceGenerator(CString programPath, CString programName) {
        
        file = new CFile(programPath, programName + ".msrc", programName + ".mout", "");
        CVariableTable varTable(programPath, programName);
        symbolValues = varTable.getSymbolTable();
        replaceSymbolWithAddress();
    }
    
    ~COutSourceGenerator() {
        
    }
};