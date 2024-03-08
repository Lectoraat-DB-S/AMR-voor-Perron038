CASE PROGRAM_STATE OF
    0 :      (* Value can be a single value *)
        OUT1 := 1;
        OUT8 := 0;
        PROGRAM_STATE := 1;
    1 : 
    OUT2 := 1;
    OUT1 := 0;
    PROGRAM_STATE := 2;
    2 : 
    OUT3 := 1;
    OUT2 := 0;
    PROGRAM_STATE := 3;
    3: 
    OUT4 := 1;
    OUT3 := 0;
    PROGRAM_STATE := 4;
    4 : 
    OUT5 := 1;
    OUT4 := 0;
    PROGRAM_STATE := 5;
    5 : 
    OUT6 := 1;
    OUT5 := 0;
    PROGRAM_STATE := 6;
    6 : 
    OUT7 := 1;
    OUT6 := 0;
    PROGRAM_STATE := 7;
    7 : 
    OUT8 := 1;
    OUT7 := 0;
    PROGRAM_STATE := 0;
    ELSE 
        PROGRAM_STATE := 0;
END_CASE