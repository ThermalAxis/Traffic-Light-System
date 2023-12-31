
            start
            pattern 10, [%10000000, %00000000]  ' Reset Outputs
            gosub sub_CR_Red  ' Toggle Red Crossing Light
            gosub sub_A_Red  ' Toggle Set A Red
            gosub sub_B_Red  ' Toggle Set B Red
            gosub sub_A_Amber  ' Toggle Set A Amber
            wait 2.5
            do until 1 = 2  ' Loop FOREVER
                gosub sub_A_Red  ' Toggle Set A Red
                gosub sub_A_Amber  ' Toggle Set A Amber
                gosub sub_A_Green  ' Toggle Set A Green
label_1:
                wait 10  ' Wait 10 Sec
                if input 3 = 1 then goto label_10  ' Is Set A Sensor Tripped?
                gosub sub_A_Green  ' Toggle Set A Green
                gosub sub_A_Amber  ' Toggle Set A Amber
                wait 2.5  ' Wait 2.5 Sec
                gosub sub_A_Amber  ' Toggle Set A Amber
                gosub sub_A_Red  ' Toggle Set A Red
                if C = 255 then goto label_9  ' Crossing Button Pressed?
label_2:
                gosub sub_B_Amber  ' Toggle Set B Amber
                wait 2.5  ' Wait 2.5 Sec
                gosub sub_B_Red  ' Toggle Set B Red
                gosub sub_B_Amber  ' Toggle Set B Amber
                gosub sub_B_Green  ' Toggle Set B Green
                wait 10  ' Wait 10 Sec
                if input 1 = 1 then goto label_6  ' Is Set B Sensor Tripped?
label_3:
                gosub sub_B_Green  ' Toggle Set B Green
                gosub sub_B_Amber  ' Toggle Set B Amber
                wait 2.5  ' Wait 2.5 Sec      a
                gosub sub_B_Amber  ' Toggle Set B Amber
                gosub sub_B_Red  ' Toggle Set B Red
                if C = 255 then goto label_5  ' Crossing Button Pressed?
label_4:
                gosub sub_A_Amber  ' Toggle Set A Amber
                wait 2.5  ' Wait 2.5 Sec
            loop
            return
label_5:
            gosub sub_Crossing  ' Call Crossing Subroutine
            goto label_4

sub_Crossing:
            wait 2.5  ' Wait 2.5 Sec
            gosub sub_CR_Red  ' Toggle Red Crossing Light
            gosub sub_Wait_LED  ' Toggle Wait LED
            gosub sub_CR_Green  ' Toggle Green Crossing Light
            gosub sub_Buzzer  ' Pulse Buzzer
            gosub sub_CR_Flash  ' Flash Green Crossing Light
            gosub sub_CR_Red  ' Toggle Red Crossing Light
            gosub sub_CR_Green  ' Toggle Green Crossing Light
            clear C  ' Set Variable C to 0
            wait 2.5  ' Wait 2.5 Sec
            set A  ' Set Variable A to 255
            return

sub_CR_Flash:
            for time 5 seconds
                for I = 1 to 10
                    pattern 50, [%00110000, %00000001, %00110000, %00000001]
                next
            next
            return

sub_Buzzer:
            for time 10 seconds
                for I = 1 to 10
                    pulse 6, 2
                next
                pause 100
            next
            return

sub_CR_Green:
            pattern 10, [%00110000, %00000001, %00000000]  ' Toggle O12
            return

sub_Wait_LED:
            pattern 25, [%00010100, %00000001, %00000000]  ' Toggle O5
            return
label_6:
            gosub sub_B_Sense
            goto label_3

sub_B_Sense:
            if input 3 = 1 then goto label_8  ' Is Set A Sensor Tripped
            do until 1 = 2  ' Loop FOREVER
                wait 10  ' Wait 10 Sec
                if input 3 = 1 then goto label_7  ' Is Set A Sensor Tripped?
                if C = 255 then goto label_7  ' Crossing Button Pressed?
            loop
label_7:
            return
label_8:
            wait 10  ' Who dat is?
            goto label_7  ' Kappa

sub_B_Green:
            pattern 10, [%00111000, %00000001, %00000000]  ' Toggle O14
            return

sub_B_Amber:
            pattern 10, [%00111100, %00000001, %00000000]  ' Toggle O15
            return
label_9:
            gosub sub_Crossing  ' Call Crossing Subroutine
            goto label_2
label_10:
            gosub sub_A_Sense  ' Call Set A Sense Subroutine
            goto label_1

sub_A_Sense:
            if input 1 = 1 then goto label_11  ' Is Set B Sensor Tripped
            do until 1 = 2  ' Loop FOREVER
                wait 10  ' Wait 10 Sec
                if C = 255 then goto label_11  ' Crossing Button Pressed?
                if input 1 = 1 then goto label_11  ' Is Set B Sensor Tripped?
            loop
label_11:
            return

sub_A_Green:
            pattern 10, [%00100000, %00000001, %00000000]  ' Toggle O8
            return

sub_A_Amber:
            pattern 10, [%00101100, %00000001, %00000000]  ' Toggle O11
            return

sub_B_Red:
            pattern 10, [%00100100, %00000001, %00000000]  ' Toggle O9
            return

sub_A_Red:
            pattern 10, [%00101000, %00000001, %00000000]  ' Toggle O10
            return

sub_CR_Red:
            pattern 10, [%00110100, %00110101, %00000000]  ' Toggle O13
            return

            start
label_12:
            if input 2 = 0 then goto label_12  ' Crossing Button Pressed?
            gosub sub_Wait_LED  ' Toggle Wait LED
            set C  ' Set Variable C To 255
label_13:
            if A <> 255 then goto label_13
            clear A  ' Set Variable A to 0
            goto label_12
