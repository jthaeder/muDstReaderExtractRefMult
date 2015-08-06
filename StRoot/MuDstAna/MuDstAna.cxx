#include <iostream>
#include <fstream>

#include "StMuDSTMaker/COMMON/StMuDstMaker.h"
#include "StMuDSTMaker/COMMON/StMuDst.h"
#include "StMuDSTMaker/COMMON/StMuTrack.h"
#include "StMuDSTMaker/COMMON/StMuEvent.h"

#include "MuDstAna.h"

using namespace std;

ClassImp(MuDstAna);

// ___________________________________________________________________________________
MuDstAna::MuDstAna(StMuDstMaker* maker, const char* outName) : 
  StMaker("MuDstAna"), 
  mMuDstMaker(maker), 
  mOutFile(NULL),
  mOutFileName(Form("%s.refMult.txt", outName)) {
}

// ___________________________________________________________________________________
MuDstAna::~MuDstAna() {
}

// ___________________________________________________________________________________
Int_t MuDstAna::Init() {
  mOutFile = new ofstream(mOutFileName);
  *mOutFile << "run       event     gRefMult   refMult  refMult2" << endl;
   
  return kStOK;
}

// ___________________________________________________________________________________
Int_t MuDstAna::Make() {
   StMuDst*   muDst   = mMuDstMaker->muDst();
   StMuEvent* muEvent = muDst->event();

   int refMult2 = 0;

   //   cout << "xxx NT  " << muDst->primaryTracks()->GetEntries() << endl;

   for (Int_t itrk=0; itrk < muDst->primaryTracks()->GetEntries(); itrk++){
     StMuTrack* track = muDst->primaryTracks(itrk);
   
     //     cout << "xxx  0 " << endl;
     if(!track) 
       continue;
     
     //     cout << "xxx  1 " << endl;
     if (track->flag()<0 || track->nHitsFit(kTpcId)<10) 
       continue;

     //     cout << "xxx  2 " << endl;
     if (fabs(track->momentum().mag())<1.e-10) 
       continue;

     const Double_t eta = track->momentum().pseudoRapidity() ;
     if( (eta > -1.0 && eta < -0.5) || (eta > 0.5 && eta < 1.0) ) {
       if (track->dca().mag()<3)
	 ++refMult2;
     }
     else
       continue;
   } 

   cout << muEvent->runNumber() 
	     << "     " << muEvent->eventNumber() 
	     << "     " << muEvent->grefmult() 
	     << "     " << muEvent->refMult()
	     << "     " << refMult2 << endl;               
   
   *mOutFile << muEvent->runNumber() 
	     << "     " << muEvent->eventNumber() 
	     << "     " << muEvent->grefmult() 
	     << "     " << muEvent->refMult()
	     << "     " << refMult2 << endl;

   return kStOK;
}


// ___________________________________________________________________________________
Int_t MuDstAna::Finish() {
   return kStOk;
}
