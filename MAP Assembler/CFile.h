//
//  CFile.h
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#ifndef __ManoAssembler__CFile__
#define __ManoAssembler__CFile__

#define END_OF_FILE "//;FILE_END;\\"
#define FILE_OPENNING_ERROR "//;FILE_OPENNING_ERROR;\\"

#include <iostream>
#include "CString.h"

#endif /* defined(__ManoAssembler__CFile__) */

class CFile {

    FILE *sourceFile;
    FILE *outSourceFile;
    FILE *outBinarySourceFile;
    CString path;
    CString sourceFileName;
    CString outSourceFileName;
    CString outBinarySourceFileName;
    enum FileType {source, outSource, outBinary};
    
    CString createNewPath(FileType);
    void fileOpen (FILE *, FileType, CString);
    void fileClose (FileType);
    
public:
    
    CFile(CString path,
          CString sourceFileName,
          CString outSourceFileName,
          CString outBinarySourceFileName) {
        this -> path = path;
        this -> sourceFileName = sourceFileName;
        this -> outSourceFileName = outSourceFileName;
        this -> outBinarySourceFileName = outBinarySourceFileName;
        
        this -> sourceFile = nullptr;
        this -> outSourceFile = nullptr;
        this -> outBinarySourceFile = nullptr;
    }
    
    ~CFile() {
        fileClose(source);
        fileClose(outSource);
        fileClose(outBinary);
    }
    
    CString contentOfSpecifiedFile() {
        fileOpen(sourceFile, source, "r");
        if (sourceFile != nullptr && !errno) {
            size_t *lineSize = new size_t();
            CString fileContent = fgetln(sourceFile, lineSize);
            return fileContent;
        }
        return FILE_OPENNING_ERROR;
    }
    
    CString readLineFromSourceFile();
    void goToFileBegginnig();
    bool writeLineToOutSourceFile(CString);
    bool writeToOutBinarySourceFile(int, size_t);
    static bool deleteFile(CString);
};