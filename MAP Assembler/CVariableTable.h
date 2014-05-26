//
//  CVariableTable.h
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Modified by MANili Inc. on 5/17/2014.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#ifndef __ManoAssembler__CVariableTable__
#define __ManoAssembler__CVariableTable__

#include <iostream>
#include "CDictionary.h"

#endif /* defined(__ManoAssembler__CVariableTable__) */

class CVariableTable {
    
    CDictionary symbolTable;
    CString programName;
    CString programPath;
    
    void passI(int &, CString);
    void generateTable();
    
public:

    CVariableTable(CString programPath, CString programName) {
        this -> programPath = programPath;
        this -> programName = programName;
        generateTable();
    }
    
    ~CVariableTable() {
        
    }
    
    static int intValue(CString);
    static CString stringValue(CString, bool isLabel = false);
    
    CDictionary getSymbolTable() {
        CDictionary temp = symbolTable;
        return temp;
    }
};