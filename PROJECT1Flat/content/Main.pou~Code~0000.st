//Code die bepaald welke van de programma's aangeroepen moet worden...
PROGRAM_SELECT := 1;



CASE PROGRAM_SELECT OF
    0: //IDLE

    1:
    // Case diagram voor oppakken van AWL opstelling
        CASE PROGRAM_STATE OF
            0 : //Idle
            
            1 :  //Move stepper forward until end
                q_StepperFWD := 1;
                WHILE NOT i_EndStopFWD DO
                    //Wachten
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
    2: 
    //Case diagram voor wegzetten op AWL opstelling
        CASE PROGRAM_STATE OF 
            0 : //Idle
            
            1 :  //Move stepper forward until drop off position
                q_StepperFWD := 1;
                WHILE NOT i_EndStopFWDShort DO
                    //Wachten
                    END_WHILE
                q_StepperFWD := 0;
                PROGRAM_STATE := 2;
            2 : //Move stepper backward and check if plate is dropped
                q_StepperBWD := 1;
                t_PlateDetectionTimeOut.PT := T#10s;
                t_PlateDetectionTimeOut.IN := 1;
            
                IF t_PlateDetectionTimeOut.Q THEN //succes
                    PROGRAM_STATE := 3;
                    t_PlateDetectionTimeOut.IN := 0;
                    t_PlateDetectionTimeOut.PT := T#10s;
                    END_IF;
                
                IF i_PlateDetection THEN //ERROR
                    PROGRAM_STATE := 99;//ERROR STATE
                    t_PlateDetectionTimeOut.IN := 0;
                    t_PlateDetectionTimeOut.PT := T#10s;
                    END_IF;
                    
            3 : //Stop stepper at endstop bwd and send signal that pick-up routine is done.
                WHILE NOT i_EndStopBWD DO
                    //Wachten
                    END_WHILE;
                q_StepperBWD := 0;
                q_DropOffRoutineDone := 1;
                PROGRAM_STATE := 0;
            99 : 
            //ERROR CASE
                q_StepperBWD:= 0;
                q_StepperFWD := 0;
                q_DropOffRoutineDone:= 0;
            
            END_CASE
            
    3:
    //Case diagram voor oppakken van Lastafel
    

    4:
    //Case diagram voor wegzetten op Lastafel

    ELSE
        PROGRAM_SELECT := 0;
   
END_CASE