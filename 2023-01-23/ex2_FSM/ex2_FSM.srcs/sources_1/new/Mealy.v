`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Exam:        2023-01-23
// Exercise:    2: FSM verilog   
// 
//////////////////////////////////////////////////////////////////////////////////


module Mealy_verilog(
    input   F,
    input   B,
    input   ok,
    output reg [1:0] TL,
    input   clk,
    input   rst
    );
    
    parameter off = 0, car_waiting = 1, go = 2, crossing = 3;
    
    reg [1:0] state, nextState;
    
    // State update process
    always @(posedge clk,posedge rst) begin
        if (rst == 1)
            state <= off;
        else 
            state <= nextState;
    end
    
    always @(state, F, B, ok) begin
        case (state)
            off: begin
                if (F == 1) begin
                    TL <= 2;
                    nextState <= car_waiting;                    
                end else begin
                    nextState <= off;
                    TL <= 0;
                end
            end
            
            car_waiting: begin
                if (ok == 1) begin
                    nextState <= go;
                    TL <= 1;
                end else begin
                    nextState <= car_waiting;
                    TL <= 2;
                end
            end            
            
            go: begin
                if (B == 0) begin
                    nextState <= crossing;
                    TL <= 2;
                end else begin
                    nextState <= go;
                    TL <= 1;
                end
            end   
            
            crossing: begin
                if (B == 1 && F == 1) begin
                    nextState <= car_waiting;
                    TL <= 2;
                end else if (B == 1 && F == 0) begin
                    nextState <= off;
                    TL <= 0;
                end else begin
                    nextState <= crossing;
                    TL <= 2;
                end
            end   
        endcase
    end
endmodule
