       01 G-DISTSCRN.
         02 LINE 1 COL 1 VALUE "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
      -"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿".
         02 LINE 2 COL 1 VALUE "³                               __
      -"                                      ³".
         02 LINE 3 COL 1 VALUE "³                        /\ . _|__)_  _|
      -"_  |_ _    /\ . _ _  _  _|_           ³".
         02 LINE 4 COL 1 VALUE "³                       /--\|| |  (_)| |
      -"_  |_(_)  /--\|| |_)(_)| |_           ³".
         02 LINE 5 COL 1 VALUE "³
      -"                 |                    ³".
         02 LINE 6 COL 1 VALUE "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
      -"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´".
         02 LINE 7 COL 1 VALUE "³  Calculate distance between airports
      -"                                      ³".
         02 LINE 8 COL 1 VALUE "³
      -"                                      ³".
         02 LINE 9 COL 1 VALUE "³
      -"                                      ³".
         02 LINE 10 COL 1 VALUE "³  If you wish to know the distance bet
      -"ween two airports, please enter the    ³".
         02 LINE 11 COL 1 VALUE "³   IATA code for each airport in the f
      -"ields below:                           ³".
         02 LINE 12 COL 1 VALUE "³
      -"                                       ³".
         02 LINE 13 COL 1 VALUE "³
      -"         ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´".
         02 LINE 14 COL 1 VALUE "³      Airport one    :
      -"         ³                             ³".
         02 LINE 15 COL 1 VALUE "³
      -"         ³                             ³".
         02 LINE 16 COL 1 VALUE "³
      -"         ³                             ³".
         02 LINE 17 COL 1 VALUE "³      Airport two    :
      -"         ³ Distance in km :            ³".
         02 LINE 18 COL 1 VALUE "³
      -"         ³                             ³".
         02 LINE 19 COL 1 VALUE "³
      -"         ³ Distance in miles :         ³".
         02 LINE 20 COL 1 VALUE "³
      -"         ³                             ³".
         02 LINE 21 COL 1 VALUE "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
      -"ÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ".
         02 LINE 14 COL 26 PIC X(4) USING ls-airport1 AUTO.
         02 LINE 15 COL 51 PIC X(27) FROM ls-from-to-msg.
         02 LINE 17 COL 26 PIC X(4) USING ls-airport2 AUTO.
         02 LINE 17 COL 71 PIC X(7) FROM distance-km.
         02 LINE 19 COL 71 PIC X(7) FROM distance-miles.
