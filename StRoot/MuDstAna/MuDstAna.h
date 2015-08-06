#ifndef MUDSTANA_H
#define MUDSTANA_H

#include <fstream>
#include "TString.h"
#include "StMaker.h"

class StMuDstMaker;

class MuDstAna : public StMaker {
public:
  MuDstAna(StMuDstMaker* maker, const char* outName);
  virtual ~MuDstAna();
  
  Int_t Init();
  Int_t Make();
  Int_t Finish();
  
 private:
  StMuDstMaker* mMuDstMaker;
  ofstream*     mOutFile;
  TString       mOutFileName;
   
   ClassDef(MuDstAna, 0)
};
#endif

