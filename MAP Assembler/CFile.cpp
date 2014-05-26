//
//  CFile.cpp
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

#include "CFile.h"

CString CFile::createNewPath(FileType fileType) {
    switch (fileType) {
        case source:
            
            return path + sourceFileName.value();
        break;
            
        case outSource:
            return path + outSourceFileName.value();
        break;
            
        case outBinary:
            return path + outBinarySourceFileName.value();
        break;
    }
}

void CFile::fileOpen (FILE *file, FileType fileType, CString mode) {
    char *tempPath = createNewPath(fileType).value();
    char *tempMode = mode.value();
    file = fopen(tempPath, tempMode);
    if (file != nullptr) {
        switch (fileType) {
            case source:
                sourceFile = file;
                break;
            case outSource:
                outSourceFile = file;
                break;
            case outBinary:
                outBinarySourceFile = file;
                break;
        }
    }
    else {
        sourceFile = nullptr;
    }
}

void CFile::fileClose(FileType fileType) {
    switch (fileType) {
        case source:
            if (sourceFile != nullptr) {
                fclose(sourceFile);
                sourceFile = nullptr;
            }
        break;
        case outSource:
            if (outSourceFile != nullptr) {
                fclose(outSourceFile);
                outSourceFile = nullptr;
            }
        break;
        case outBinary:
            if (outBinarySourceFile != nullptr) {
                fclose(outBinarySourceFile);
                outBinarySourceFile = nullptr;
            }
        break;
    }
}

void CFile::goToFileBegginnig() {
    if (sourceFile != nullptr)
        rewind(sourceFile);
}

CString CFile::readLineFromSourceFile() {
    CString temp = "";
    if (sourceFile == nullptr)
        fileOpen(sourceFile, source, "r");
    if (sourceFile != nullptr) {
        if (!feof(sourceFile)) {
            size_t *lineSize = new size_t();
            CString fileContent = fgetln(sourceFile, lineSize);
            char *lineTemp = new char[*lineSize]();
            for (int i = 0; i < *lineSize && fileContent.value() != nullptr; i++) {
                    lineTemp[i] = fileContent.value()[i];
            }
            temp = lineTemp;
        }
        else if (feof(sourceFile))
            return END_OF_FILE;
    }
    else {
        return END_OF_FILE;
    }
    return temp;
}

bool CFile::writeLineToOutSourceFile(CString lineToWrite) {
    fileOpen(outSourceFile, outSource, "a");
    if (outSourceFile != nullptr) {
        fputs(lineToWrite.value(), outSourceFile);
        if (!lineToWrite.findText("\n")) {
            fputc('\n', outSourceFile);
        }
        fileClose(outSource);
        return true;
    }
    return false;
}

bool CFile::writeToOutBinarySourceFile(int content, size_t size) {
    fileOpen(outBinarySourceFile, outBinary, "a");
    if (outBinarySourceFile != nullptr) {
        fwrite(&content, size, size, outBinarySourceFile);
        fileClose(outBinary);
        return true;
    }
    return false;
}

bool CFile::deleteFile(CString fileName) {
    if (remove(fileName.value())) {
        return true;
    }
    return false;
}





