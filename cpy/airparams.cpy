      ******************************************************************
      *
      * Copyright (C) Micro Focus 1984-2014. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************

       01 (ap-prefix)-function                      pic x.
           88 get-matches                           value "1".
           88 get-distance                          value "2".
           88 get-details                           value "3".
           88 open-file                             value "4".
           88 close-file                            value "5".
           88 display-record                        value "6".
       01 (ap-prefix)-airport1                      pic x(4).
       01 (ap-prefix)-airport2                      pic x(4).
       01 (ap-prefix)-prefix-text                   pic x(4).
       01 (ap-prefix)-distance-result.
           03 distance-km               pic zz,zz9.
           03 distance-miles            pic zz,zz9.
       01 (ap-prefix)-matched-codes-array           pic x(350).
       01 (ap-prefix)-matched-codes                 redefines 
          (ap-prefix)-matched-codes-array pic x(35) occurs 10.
       01 (ap-prefix)-file-status    pic xx.
