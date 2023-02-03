      ******************************************************************
      *
      * Copyright (C) Micro Focus 2017-2018. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

       copy "mfunit_prototypes.cpy".

       program-id. TestGetMatches.
       working-storage section.
       copy "mfunit.cpy".
       78 TEST-TESTGETMATCHES value "TestGetMatches".
       01 pp procedure-pointer.

      *> Program linkage data
       01 lnk-function PIC X.
           88 get-matches                           value "1".
           88 get-distance                          value "2".
           88 get-details                           value "3".
           88 open-file                             value "4".
           88 close-file                            value "5".
           88 display-record                        value "6".
       01 lnk-airport1 PIC X(4).
       01 lnk-airport2 PIC X(4).
       01 lnk-prefix-text PIC X(4).
       01 lnk-distance-result.
         03 distance-km PIC ZZ,ZZ9.
         03 distance-miles PIC ZZ,ZZ9.
       01 lnk-matched-codes-array PIC X(350).
       01 lnk-matched-codes PIC X(35) occurs 10 redefines lnk-matched-codes-array.
       01 lnk-file-status PIC XX.
       01 lnk-rec.
         03 ap-code PIC X(4).
         03 ap-name PIC X(30).
         03 ap-city PIC X(30).
         03 ap-country PIC X(20).
         03 ap-geo.
           05 ap-latitude.
             07 ap-lat-sign PIC X.
             07 ap-lat-degs PIC 9(3).
             07 ap-lat-mins PIC 9(6).
           05 ap-longitude.
             07 ap-long-sign PIC X.
             07 ap-long-degs PIC 9(3).
             07 ap-long-mins PIC 9(6).

      *> Variable used when initializing 'occurs' items
       01 i pic 99.


       procedure division.
           goback returning 0
       .

       entry MFU-TC-PREFIX & TEST-TESTGETMATCHES.

          *> expected passing case
           set get-matches to true
           move "MA" to lnk-prefix-text

           call "AIRCODE" using
                       by value lnk-function
                       by value lnk-airport1
                       by value lnk-airport2
                       by value lnk-prefix-text
                       by reference lnk-rec
                       by reference lnk-distance-result
                       by reference lnk-matched-codes-array
                       by reference lnk-file-status
           end-call

           *> ensure we have some data returned
           if lnk-matched-codes(1) equal spaces or
              lnk-matched-codes(2) equal spaces or
              lnk-matched-codes(3) equal spaces
               call MFU-ASSERT-FAIL-Z using by reference z"MA should have been found"
           end-if

           exhibit named lnk-matched-codes(1)
           exhibit named lnk-matched-codes(2)
           exhibit named lnk-matched-codes(3)
           goback returning MFU-PASS-RETURN-CODE
       .

      $region TestCase Configuration

       entry MFU-TC-SETUP-PREFIX & TEST-TESTGETMATCHES.
           *> Load the library that is being tested
           set pp to entry "aircode"

           initialize lnk-function
           initialize lnk-airport1
           initialize lnk-airport2
           initialize lnk-prefix-text
           initialize lnk-distance-result
           initialize lnk-matched-codes-array
           perform varying i from 1 by 1 until i > 10
               initialize lnk-matched-codes(i)
           end-perform
           initialize lnk-file-status
           initialize lnk-rec

           set open-file to true
           call "AIRCODE" using
                       by value lnk-function
                       by value lnk-airport1
                       by value lnk-airport2
                       by value lnk-prefix-text
                       by reference lnk-rec
                       by reference lnk-distance-result
                       by reference lnk-matched-codes-array
                       by reference lnk-file-status
           goback returning 0
       .

       entry MFU-TC-TEARDOWN-PREFIX & TEST-TESTGETMATCHES.
           *> set lnk-function to close the data file which contains the airport codes
           set close-file to true
           call "AIRCODE" using
                       by value lnk-function
                       by value lnk-airport1
                       by value lnk-airport2
                       by value lnk-prefix-text
                       by reference lnk-rec
                       by reference lnk-distance-result
                       by reference lnk-matched-codes-array
                       by reference lnk-file-status
           end-call

           *> did we close the file?
           if lnk-file-status not equal "00"
               call MFU-ASSERT-FAIL-Z using TEST-TESTGETMATCHES & " failed to close file" & x"0"
               exhibit named lnk-file-status
           end-if
       .
      $end-region

       end program.
