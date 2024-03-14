/*CASE PROGRAM_STATE OF
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

*/


//BINARY COUNTER
/*
IF ZeroToTwoFiveFive < BYTE#16#FF THEN
    OutArray := ZeroToTwoFiveFive;
    TempIntByte := TO_INT(ZeroToTwoFiveFive);
    TempIntByte := TempIntByte +2;
    ZeroToTwoFiveFive := TO_BYTE(TempIntByte);
 ELSIF ZeroToTwoFiveFive = BYTE#16#FF THEN
    ZeroToTwoFiveFive := 0;

    END_IF
    
   */
  
  IF i_PickupRoutineStart THEN
   CASE PROGRAM_STATE OF
       0 : //Idle
            IF  i_PickupRoutineStart THEN
                PROGRAM_STATE := 1;
                END_IF;
       1 :  //Move stepper forward until end
            q_StepperFWD := 1;
            WHILE NOT i_EndStopFWD DO
                
                END_WHILE
            q_StepperFWD := 0;
            PROGRAM_STATE := 2;
       2 : //Move stepper backward and check if plate is taken
           q_StepperBWD := 1;
            t_PlateDetectionTimeOut.PT := T#10s;
            t_PlateDetectionTimeOut.IN := 1;
            
            IF t_PlateDetectionTimeOut.Q THEN //TIME OUT
                PROGRAM_STATE := 99;//ERROR STATE
                t_PlateDetectionTimeOut.IN := 0;
                t_PlateDetectionTimeOut.PT := T#10s;
            END_IF;
                
            IF i_PlateDetection THEN //SUCCES
                PROGRAM_STATE := 3;
                t_PlateDetectionTimeOut.IN := 0;
                t_PlateDetectionTimeOut.PT := T#10s;
            END_IF;
       3 : //Stop stepper at endstop bwd and send signal that pick-up routine is done.
            WHILE NOT i_EndStopBWD DO
                //Wachten
            END_WHILE;
            q_StepperBWD := 0;
            q_PickUpRoutineDone := 1;
            PROGRAM_STATE := 0;
      99 : 
      //ERROR CASE
      q_StepperBWD:= 0;
      q_StepperFWD := 0;
      q_PickUpRoutineDone:= 0;                

       ELSE 
           PROGRAM_STATE := 0;
   END_CASE
   END_IF;