//
//  CExecutableFileGenerator.h
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Modified by MANili Inc. on 5/17/2014.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#ifndef __ManoAssembler__CExecutableFileGenerator__
#define __ManoAssembler__CExecutableFileGenerator__

#include <iostream>
#include "COutSourceGenerator.h"

#endif /* defined(__ManoAssembler__CExecutableFileGenerator__) */


class CExecutableFileGenerator {
    
    CString programPath;
    CString programName;
    CString INS_Table_Name;
    CString System_Files_Path;
    
    void generateBinaryFile();
    
public:
    
    CExecutableFileGenerator(CString programPath, CString programName, CString INS_Table_Name, CString System_Files_Path) {
        this -> programPath = programPath;
        this -> programName = programName;
        this -> INS_Table_Name = INS_Table_Name;
        this -> System_Files_Path = System_Files_Path;
        
        COutSourceGenerator outSourceFile(programPath, programName);
        generateBinaryFile();
    }
    
    ~CExecutableFileGenerator() {
        CString fileToRemoveTemp = programPath + programName.value();
        CString fileToRemove = fileToRemoveTemp + ".mout";
        CFile::deleteFile(fileToRemove.value());
    }
    
};