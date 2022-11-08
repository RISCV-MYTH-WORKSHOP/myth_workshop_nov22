\m4_TLV_version 1d: tl-x.org
\SV
   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
  
   |calc
      @0
         $reset = *reset; 
      @1       
         $val1[31:0] = >>2$out[31:0];
         $val2[31:0] = $rand2[3:0];
         
         $sum[31:0]  = $val1[31:0] + $val2[31:0]; 
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
         
         $valid = $reset ? 1'b0 : >>1$valid+1;
      @2   
         $out[31:0] = ($reset | !$valid) ? 32'b0: $op[1] ? $op[0] ? $quot[31:0] : $prod[31:0] : $op[0] ? $diff[31:0] : $sum[31:0];
         

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
   
   
  // Calculator with validity
  
  \m4_TLV_version 1d: tl-x.org
\SV

   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
  
   |calc
      @0
         $reset = *reset;
      @1
         $valid_reset = ($valid || $reset);
         $valid = $reset ? 1'b0 : >>1$valid+1;
      ?$valid
         @1 $val1[31:0] =  >>2$out[31:0];
            $val2[31:0] =  $rand2[3:0];
            $sum[31:0]  = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
         @2   
            $out[31:0] = $valid_reset ? (($op[1:0]==2'b00) ? $sum:
                                                     ($op[1:0]==2'b01) ? $diff:
                                                     ($op[1:0]==2'b10) ? $prod:$quot):>>1$out[31:0];


   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

   
   
