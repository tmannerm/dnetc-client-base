// Hey, Emacs, this a -*-C++-*- file !

// Copyright distributed.net 1997-1999 - All Rights Reserved
// For use in distributed.net projects only.
// Any other distribution or use of this source violates copyright.

// $Log: client.h,v $
// Revision 1.94.2.4  1999/01/04 02:06:39  remi
// Synced with :
//
//  Revision 1.111  1999/01/01 02:45:14  cramer
//  Part 1 of 1999 Copyright updates...
//
// Revision 1.94.2.3  1998/12/28 16:42:41  remi
// Synced with :
//   Revision 1.100  1998/11/28 19:44:34  cyp
//   InitializeLogging() and DeinitializeLogging() are no longer Client class
//   methods.
//
// Revision 1.94.2.2  1998/11/08 11:50:31  remi
// Lots of $Log tags.
//

#ifndef __CLIBASICS_H__
#define __CLIBASICS_H__

#include "cputypes.h"

class Client
{
public:
  s32  timeslice;
  s32  cputype;

protected:
  u32 totalBlocksDone[2];
  u32 old_totalBlocksDone[2];

public:
  Client();
  ~Client() {};


  int Main( int argc, const char *argv[], int restarted );
  //encapsulated main().  client.Main() is restartable

  int ParseCommandline( int runlevel, int argc, const char *argv[], 
                        int *retcodeP, int logging_is_initialized );
                        
  //runlevel == 0 = ReadConfig() (-quiet, -ini, -guistart etc done here too)
  //         >= 1 = post-readconfig (override ini options)
  //         == 2 = run "modes"

  void ValidateConfig( void );
    // verifies configuration and forces valid values

  int SelectCore(int quietly); //always returns zero.
    // to configure for cpu. called before Run() from main(), or for 
    // "modes" (Benchmark()/Test()) from ParseCommandLine().

  unsigned int LoadSaveProblems(unsigned int load_problem_count, int retmode);
    // returns actually loaded problems 

  void Client::DisplayHelp( void );  
    // Display help text
};

// --------------------------------------------------------------------------

#endif // __CLIBASICS_H__

