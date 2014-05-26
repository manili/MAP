//
//  CExecutableFileGenerator.cpp
//  MAP Assembler
//
//  Created by MANili Inc. on 11/27/13.
//  Modified by MANili Inc. on 5/17/2014.
//  Copyright (c) 2014 MANili Inc. All rights reserved.
//

///////////////////////////////////////////////////////////////
//CAUTION : DO NOT USE BACK ORIGIN !                         //
//CAUTION : ORG VALUE CANT BE LESS THAN PREVIOUS INS COUNTS !//
///////////////////////////////////////////////////////////////

#include "CExecutableFileGenerator.h"

#define NOP 0 //No operation command

void CExecutableFileGenerator::generateBinaryFile() {
    int locationCounter = 0;
    CFile file(programPath, programName + ".mout", "", programName + ".mexe");
    CString outSourceLine = file.readLineFromSourceFile();
    while (outSourceLine != END_OF_FILE && outSourceLine != "") {
        
        if (outSourceLine.findText("ORG")) {
            int oringin = CVariableTable::intValue(outSourceLine);
            int nopCount = (oringin) - (locationCounter - 1); // -1 is because of ORG it self
            
            for (int i = 1; i < nopCount; i++)
                file.writeToOutBinarySourceFile(NOP, 1); // 1 means 8bit Ins
            locationCounter = oringin; // locationCounter completely changed
            outSourceLine = file.readLineFromSourceFile();
        } else {
            CFile insFile(System_Files_Path, INS_Table_Name, "", "");
            CString tableINS = insFile.readLineFromSourceFile();
            CString sourceCodeINS = CVariableTable::stringValue(outSourceLine);
            while (tableINS != END_OF_FILE) {
                CString tableInstruction = CVariableTable::stringValue(tableINS);
                if (tableInstruction == sourceCodeINS.value()) {
                    
                    int OpCode = CVariableTable::intValue(tableINS);
                    int ins_Parameters = CVariableTable::intValue(outSourceLine) << 1; //Sometimes addresses or immediates. Sometimes nothing like HLT
                    if (outSourceLine.findText("R2")) {
                        ins_Parameters = ins_Parameters | 1;
                    }
                    
                    int finalOpCode = OpCode | ins_Parameters;
                    file.writeToOutBinarySourceFile(finalOpCode, 1);  // 1 means 8bit Ins
                    break;
                }
                tableINS = insFile.readLineFromSourceFile();
            }
            outSourceLine = file.readLineFromSourceFile();
            locationCounter++;
        }
    }
}