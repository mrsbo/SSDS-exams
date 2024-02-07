`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Exam:        2022-01-26
// Exercise:    2: FSM    
// 
//////////////////////////////////////////////////////////////////////////////////


module combLock_FSM_verilog(
    input   COMB1, 
    input   COMB2, 
    input   ENTER, 
    input   RESET, 
    input   CLK,   
    output  reg UNLOCK,
    output  reg ERR);
    
    parameter idle = 0, wait2comb = 1, unlocked = 2, error = 3;
    
    reg [1:0] state, nextState;
    
    // State update
    always @(posedge CLK) begin
        if (RESET == 1) // Synchronous reset
            state <= idle;
        else
            state <= nextState;
    end
    
    //Comb logic
    always @(state, ENTER) begin
        case (state)
            idle: begin
                UNLOCK <= 0;               
                ERR <= 0;                  
                if (ENTER == 1 && COMB1 == 1 && COMB2 == 0)
                    nextState <= wait2comb;  
                else if (ENTER == 1)    
                    nextState <= error;      
                else                         
                    nextState <= idle;       
            end
                
            wait2comb: begin
                UNLOCK <= 0;               
                ERR <= 0;                  
                if (ENTER == 1 && COMB1 == 0 && COMB2 == 1)
                    nextState <= unlocked;  
                else if (ENTER == 1)    
                    nextState <= error;      
                else                         
                    nextState <= wait2comb;       
            end
                
            unlocked: begin
                UNLOCK <= 1;
                ERR <= 0;
                nextState <= unlocked;
            end
    
            error: begin
                UNLOCK <= 0;
                ERR <= 1;
                nextState <= error;
            end
        endcase
    end                                                                                          
endmodule
