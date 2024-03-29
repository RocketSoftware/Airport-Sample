      ******************************************************************
      *
      * (C) Copyright 2019-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

       copy "mfunit_prototypes.cpy".

       program-id. TestGetDetailsDataDriven.
       working-storage section.
       copy "mfunit.cpy".
       78 TEST-TESTGETDETAILSVALIDCODE value "TestGetDetailsValidCode".
       78 TEST-TESTGETDETAILSINVALIDCODE value "TestGetDetailsInvalidCode".

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
       01 lnk-prefix-text PIC X(3).
       01 lnk-distance-result.
         03 distance-km PIC ZZ,ZZ9.
         03 distance-miles PIC ZZ,ZZ9.
       01 lnk-matched-codes-array PIC X(350).
       01 lnk-matched-codes PIC X(35) occurs 10.
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

       01 error-message pic x(255).

       01 mfu-dd-AirportCode is MFU-DD-VALUE external.
       01 mfu-dd-ExpectedCountryName is MFU-DD-VALUE external.

       procedure division.
           goback returning 0.

       entry MFU-TC-PREFIX & TEST-TESTGETDETAILSVALIDCODE.

           *> testcase that is expected to pass
           set get-details to true
           move mfu-dd-AirportCode to lnk-airport1

           call "aircode" using
                       by value lnk-function
                       by value lnk-airport1
                       by value lnk-airport2
                       by value lnk-prefix-text
                       by reference lnk-rec
                       by reference lnk-distance-result
                       by reference lnk-matched-codes-array
                       by reference lnk-file-status
           end-call

           if ap-country of lnk-rec not equal mfu-dd-ExpectedCountryName
               string mfu-dd-AirportCode " should be in " mfu-dd-ExpectedCountryName z"0" into error-message
               call MFU-ASSERT-FAIL-Z using by reference error-message
               exhibit named ap-code of lnk-rec
               exhibit named ap-country of lnk-rec
           end-if

           goback returning MFU-PASS-RETURN-CODE
       .

       entry MFU-TC-PREFIX & TEST-TESTGETDETAILSINVALIDCODE.
           set get-details to true
           move mfu-dd-AirportCode to lnk-airport1
           move spaces to lnk-rec
           call "aircode" using by value lnk-function
                                by value lnk-airport1
                                by value lnk-airport2
                                by value lnk-prefix-text
                                by reference lnk-rec
                                by reference lnk-distance-result
                                by reference lnk-matched-codes-array
                                by reference lnk-file-status
           end-call

           if ap-country of lnk-rec not equal space or
             lnk-file-status equals "00"
               call MFU-ASSERT-FAIL-Z using by reference z"get-details should have failed"
               exhibit named ap-country of lnk-rec
           end-if
           goback returning MFU-PASS-RETURN-CODE
       .


      $region TestCase Configuration

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-TESTGETDETAILSVALIDCODE.
           move "csv:TestGetDetailsValidCode.csv" to MFU-MD-TESTDATA
           goback returning 0.

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-TESTGETDETAILSINVALIDCODE.
           move "csv:TestGetDetailsInvalidCode.csv" to MFU-MD-TESTDATA
           goback returning 0.


       entry MFU-TC-SETUP-PREFIX & TEST-TESTGETDETAILSVALIDCODE.
       entry MFU-TC-SETUP-PREFIX & TEST-TESTGETDETAILSINVALIDCODE.
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

      *> set lnk-function to open the data file which contains the airport codes
           set open-file to true
           call "aircode" using
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

       entry MFU-TC-TEARDOWN-PREFIX & TEST-TESTGETDETAILSVALIDCODE.
       entry MFU-TC-TEARDOWN-PREFIX & TEST-TESTGETDETAILSINVALIDCODE.
           *> set lnk-function to close the data file which contains the airport codes
           set close-file to true
           call "aircode" using
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
               call MFU-ASSERT-FAIL-Z using TEST-TESTGETDETAILSVALIDCODE & " failed to close file" & x"0"
               exhibit named lnk-file-status
           end-if

           goback returning 0
       .

      $end-region

       end program.
