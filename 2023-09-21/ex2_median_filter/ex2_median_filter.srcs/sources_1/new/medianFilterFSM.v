`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Exam:        2023-01-23
// Exercise:    2: FSM verilog   
// 
//////////////////////////////////////////////////////////////////////////////////


module medianFilterFSM_verilog(
    input X,
    output reg Z,
    input clk,
    input rst    
    );
    
    
    parameter initX = 0, init0 = 1, init1 = 2, pp0p0 = 3, pp0p1 = 4, pp1p0 = 5, pp1p1 = 6;
    
    reg [2:0] state, nextState;
    
    always @(posedge rst , posedge clk) begin
        if (rst == 1) begin
            state <= initX;
        end else begin
            state <= nextState;
        end
    end
    
    always @(state, X) begin
        case (state)
            initX: begin
                //Z <= 'bX;
                if (X == 1) 
                    nextState <= init1;
                else
                    nextState <= init0;
            end
            
            init0: begin
                //Z <= 'bX;
                if (X == 1)
                    nextState <= pp0p1;
                else
                    nextState <= pp0p0;
            end
            
            init1: begin
                //Z <= 'bX;
                if (X == 1)
                    nextState <= pp1p1;
                else
                    nextState <= pp1p0;
            end
            
            pp0p0: begin
                Z <= 0;
                if (X == 1)
                    nextState <= pp0p1;
                else
                    nextState <= pp0p0;
            end
            
            pp0p1: begin
                Z <= 0;
                if (X == 1)
                    nextState <= pp1p1;
                else
                    // Lone 1 case
                    //state <= pp1p0;   // This would be for no filter, just 2 cycle delay
                    nextState <= pp0p0;     // clean the lone 1
            end
            
            pp1p0: begin
                Z <= 1;
                if (X == 1)
                    nextState <= pp0p1;
                else
                    nextState <= pp0p0;
            end
            
            pp1p1: begin
                Z <= 1;
                if (X == 1)
                    nextState <= pp1p1;
                else
                    nextState <= pp1p0;
            end
                    
        endcase
    
    end
    
endmodule
