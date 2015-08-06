void runMuDstAna(TString inputFileList, int nFiles, const char* outName) {
  
  gROOT->Macro("loadMuDst.C");
  gSystem->Load("StTpcDb.so");
  gSystem->Load("StDetectorDbMaker.so");
  gSystem->Load("StDbUtilities");
  gSystem->Load("StDbLib.so");
  gSystem->Load("StDbBroker.so");
  gSystem->Load("St_db_Maker");
  gSystem->Load("StTriggerUtilities");
  gSystem->Load("MuDstAna.so");
  
  // List of member links in the chain
  StChain* chain = new StChain;
  StMuDstMaker* muDstMaker = new StMuDstMaker(0, 0, "", inputFileList.Data(), "MuDst", nFiles);
  
  St_db_Maker* dbMk = 0;
  dbMk = new St_db_Maker("StarDb", "MySQL:StarDb", "MySQL:StarDb", "$STAR/StarDb");
  dbMk->SetDebug(0);
  
  StDetectorDbTriggerID* detdbid = StDetectorDbTriggerID::instance();
  
  // Turn off everything but Primary tracks in order to speed up the analysis and eliminate IO
  muDstMaker-> SetStatus("*", 0); // Turn off all branches
  muDstMaker-> SetStatus("PrimaryVertices", 1);
  muDstMaker-> SetStatus("PrimaryTracks", 1);
  muDstMaker-> SetStatus("MuEvent", 1); //.. turn on the useful branches
  muDstMaker-> SetStatus("DetectorStates", 1);
  
  cout << "input list " << inputFileList << endl;

  MuDstAna* analysisMaker = new MuDstAna(muDstMaker, outName);
  
  // Loop over the links in the chain
  chain->Init();
  chain->EventLoop(1,1000000);
  chain->Finish();
  
  // Cleanup
  delete chain;
}
