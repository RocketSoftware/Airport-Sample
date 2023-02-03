      ******************************************************************
      *
      * (C) Copyright 1984-2023 Micro Focus or one of its affiliates.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************
       program-id aircode.

       select airfile assign airfile-name
           organization indexed
           record key is f-code with no duplicates
           file status is file-status
           access dynamic.

       data division.
       fd airfile.
       01 f-rec.
       copy "airrec.cpy" replacing ==(prefix)== by ==f==.

       working-storage section.
       01 file-status.
         03 file-status-bit1         pic 9.
         03 file-status-bit2         pic 9.

       01 airport-found     pic 9.
       01 airport           pic x(5).
       78 airport-dat                  value "dd_airports".
       *> variables for get-code-matches
       01 aircode-array                pic x(350).
       01 aircode-matches              redefines
          aircode-array                pic x(35) occurs 10.
       01 idx                          pic 9(3).
       01 j                            pic 9(3).
       01 prefix-length                pic 9(3).
       78 maxtoreturn                  value 10.

       *> variables for distance calculations
       01  lat1            comp-2.
       01  long1           comp-2.
       01  lat2            comp-2.
       01  long2           comp-2.
       01  distance        comp-2.
       01  distance-m      comp-2.

       *> variable for converting angles as specified in airport file
       01  file-angle.
             07  fa-sign       pic x.
             07  fa-degs       pic 9(3).
             07  fa-mins       pic 9(6).
       01  out-angle       comp-2.

       78  radius-of-earth value 6371.  *> radius of earth in KM
       78  km-per-mile     value 1.609344.

       01 fp-helper comp-2.

       01  a1-rec.
       copy "airrec.cpy" replacing ==(prefix)== by ==a1==.
       01  a2-rec.
       copy "airrec.cpy" replacing ==(prefix)== by ==a2==.

       linkage section.
       copy "airparams.cpy" replacing ==(ap-prefix)== by ==lnk==.
       01 lnk-rec.
       copy "airrec.cpy" replacing ==(prefix)== by ==ap==.

       procedure division using by value lnk-function
                                by value lnk-airport1
                                by value lnk-airport2
                                by value lnk-prefix-text
                                by reference lnk-rec
                                by reference lnk-distance-result
                                by reference lnk-matched-codes-array
                                by reference lnk-file-status.

       main section.
           evaluate true
             when get-matches
               perform get-code-matches
             when get-distance
               perform distance-between-airports
             when get-details
               perform lookup-one-airport
             when open-file
               perform open-airfile
             when close-file
               perform close-airfile
             when display-record
               perform display-airport
           end-evaluate

           exit program
       .

       lookup-one-airport section.
           initialize lnk-rec
           move lnk-airport1 to airport
           perform find-airport
           if airport-found = 1
               move f-rec to lnk-rec
           end-if
       .

       distance-between-airports section.
       *> finds airports and distance between them
           initialize lnk-distance-result
           move lnk-airport1 to airport
           perform find-airport
           if airport-found = 1
               move f-rec to a1-rec
               move lnk-airport2 to airport
               perform find-airport
               if airport-found = 1
                   move f-rec to a2-rec
                   perform calculate-airport-distance
                   move distance to distance-km
                   move distance-m to distance-miles
               end-if
           end-if
       .

       calculate-airport-distance section.
           move a1-latitude to file-angle
           perform convert-angle
           move out-angle to lat1

           move a1-longitude to file-angle
           perform convert-angle
           move out-angle to long1

           move a2-latitude to file-angle
           perform convert-angle
           move out-angle to lat2

           move a2-longitude to file-angle
           perform convert-angle
           move out-angle to long2

           *> spherical law of cosines....
           compute distance = function acos(function sin(lat1) * function sin(lat2) + function cos(lat1) * function cos(lat2) * function cos (long2 - long1))
                              * radius-of-earth
           compute distance-m = distance / km-per-mile
       .


       convert-angle section.
       *> converts the ASCII file value to a floating point RADIAN value.
           if fa-mins = 0
               move 1 to fa-mins
           end-if

           move fa-mins to fp-helper
           perform until fp-helper < 1.0
               compute fp-helper = fp-helper * .1
           end-perform

           compute fp-helper = fp-helper * 60
           move fp-helper to fa-mins

           compute out-angle = fa-degs + (fa-mins / 60)
           if fa-sign = "-"
               multiply -1 by out-angle
           end-if
           compute out-angle = (out-angle * function pi) / 180
       .

       display-airport section.
           display f-code " " f-name
           display "     " f-country
                   "  Lat:" f-lat-sign f-lat-degs "." f-lat-mins
                   " Lon:" f-long-sign f-long-degs "." f-long-mins
       .

       get-code-matches section.
           move "00" to lnk-file-status
           move 0 to idx
           initialize aircode-array
           move 0 to prefix-length
           
           inspect lnk-prefix-text tallying prefix-length
                                   for characters before space
           move function upper-case(lnk-prefix-text) to lnk-prefix-text
           move lnk-prefix-text to f-code
           start airfile key >= f-code
               invalid key
                   move file-status to lnk-file-status
               not invalid key
                   read airfile next record
                   perform until f-code(1:prefix-length) not =
                                   lnk-prefix-text or idx >= maxtoreturn
                       add 1 to idx
                       string f-code delimited by space
                              " - " delimited by size
                              f-name delimited by size
                              into aircode-matches(idx)
                       read airfile next record
                       at end
                           exit perform
                       end-read
                   end-perform
           end-start
           *> copy the results to the result collection
           perform varying j from 1 by 1 until j > idx
               move aircode-matches(j) to lnk-matched-codes(j)
           end-perform
       .

       find-airport section.
           move 0 to airport-found
           initialize f-rec
           move function upper-case(airport) to f-code
           start airfile key = f-code
           invalid key
               move file-status to lnk-file-status
           not invalid key
               read airfile next record

               move 1 to airport-found
               move file-status to lnk-file-status
           end-start
       .

       open-airfile section.
           display airport-dat upon environment-name
           accept airfile-name from environment-value
           open input airfile
           move file-status to lnk-file-status
       .

       close-airfile section.
           close airfile
           move file-status to lnk-file-status
       .

       end program.
