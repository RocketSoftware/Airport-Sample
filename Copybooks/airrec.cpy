      ******************************************************************
      *
      * Copyright (C) Micro Focus 1984-2014. All rights reserved.
      *
      * This sample code is supplied for demonstration purposes only
      * on an "as is" basis and is for use at your own risk.
      *
      ******************************************************************
	  
           03  (prefix)-code       pic x(4).
           03  (prefix)-name       pic x(30).
           03  (prefix)-city       pic x(30).
           03  (prefix)-country    pic x(20).
           03  (prefix)-geo.
               05  (prefix)-latitude.
                   07  (prefix)-lat-sign     pic x.
                   07  (prefix)-lat-degs     pic 9(3).
                   07  (prefix)-lat-mins     pic 9(6).
               05  (prefix)-longitude.
                   07  (prefix)-long-sign    pic x.
                   07  (prefix)-long-degs    pic 9(3).
                   07  (prefix)-long-mins    pic 9(6).

