      ******************************************************************
      *
      * (C) Copyright 1984-2024 Rocket Software, Inc. or one of its affiliates. All Rights Reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

       program-id airport.
       data division.

       working-storage section.
       01  user-input      pic x(80).

       local-storage section.
       copy "airparams.cpy" replacing ==(ap-prefix)== by ==ls==.
       01 ls-rec.
       copy "airrec.cpy" replacing ==(prefix)== by ==ap==.
       01 pp procedure-pointer.
       01 ls-from-to-msg        pic x(30).
       screen section.
       copy "distscrn.ss".
       copy "distrec.ss".
       copy "DISTSRCH.ss".

       procedure division.
           set pp to entry "aircode"

           display spaces upon crt

           set open-file to true
           perform call-aircode-program

           if ls-file-status = "00"
               move spaces to ls-airport1 ls-airport2 ls-from-to-msg
               move zero to distance-km distance-miles
               display G-DISTSCRN
               perform until exit
                   accept G-DISTSCRN

                   if ls-airport1 = spaces
                       exit perform
                   end-if

                   if ls-airport2 not = spaces
                       set get-distance to true
                       move spaces to ls-from-to-msg
                       string ls-airport1 delimited by space
                              " -> " delimited by size
                              ls-airport2 delimited by space
                              into ls-from-to-msg
                       end-string
                       perform call-aircode-program
                       if ls-file-status equal "00"
                           move spaces to ls-airport1 ls-airport2
                           display G-DISTSCRN
                       else
                           perform display-invalid-code
                       end-if
                   else
                       move " " to ap-code of ls-rec
                       set get-details to true
                       perform call-aircode-program

                       if ap-code OF ls-rec <> " "
                           display G-DISTREC
                           move spaces to ls-airport1 ls-airport2
                       else
                           move spaces to ls-matched-codes-array
                           move ls-airport1 to ls-prefix-text
                           set get-matches to true
                           perform call-aircode-program
                           if ls-matched-codes(1) equal spaces
                               perform display-invalid-code
                           else
                               display G-DISTSRCH
                           end-if
                           
                       end-if
                   end-if
               end-perform

               set close-file to true
               perform call-aircode-program
           end-if
       .

       display-invalid-code section.
           display "Invalid IATA code" at 1908 
                   with foreground-color 04
           .

       call-aircode-program section.
           call "aircode" using by value ls-function
                                by value ls-airport1
                                by value ls-airport2
                                by value ls-prefix-text
                                by reference ls-rec
                                by reference ls-distance-result
                                by reference ls-matched-codes-array
                                by reference ls-file-status
       .

       end program.
