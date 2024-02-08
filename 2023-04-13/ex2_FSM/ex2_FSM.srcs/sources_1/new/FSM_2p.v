`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Exam:        2023-01-23
// Exercise:    2: FSM verilog   
// 
//////////////////////////////////////////////////////////////////////////////////


module FSM_2p(
    input En,
    input X,
    output reg[1:0] Z,
    input clk,
    input rst);
    
    parameter disabled = 0, p0 = 1, p1 = 2, p1p1 = 3;
    reg[1:0] state, nextState;
    
    
    always @(posedge clk) begin
        if (rst == 1)
            state <= disabled;
        else 
            state <= nextState;
    end
    
    always @(En, X, state) begin
        case (state)
            disabled: begin
                if (En == 0) begin
                    nextState <= disabled;
                    Z <= 'b00;
                end else if (X == 0) begin
                    nextState <= p0;
                    Z <= 'b00;
                end else begin
                    nextState <= p1;
                    Z <= 'b00;
                end                
            end
            
            p0: begin
                if (En == 0) begin
                    nextState <= disabled;
                    Z <= 'b00;
                end else if (X == 0) begin
                    nextState <= p0;
                    Z <= 'b01;
                end else begin
                    nextState <= p1;
                    Z <= 'b00;
                end  
            end
            
            p1: begin
                if (En == 0) begin
                    nextState <= disabled;
                    Z <= 'b00;
                end else if (X == 0) begin
                    nextState <= p0;
                    Z <= 'b00;
                end else begin
                    nextState <= p1p1;
                    Z <= 'b00;
                end  
            end
            
            p1p1: begin
                if (En == 0) begin
                    nextState <= disabled;
                    Z <= 'b00;
                end else if (X == 0) begin
                    nextState <= p0;
                    Z <= 'b00;
                end else begin
                    nextState <= p1p1;
                    Z <= 'b10;
                end              
            end        
        endcase    
    end

endmodule
