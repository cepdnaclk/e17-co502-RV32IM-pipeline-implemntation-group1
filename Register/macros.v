`define assert(sig, val,op) \
    if (sig !== val) begin \
        $display("ASSERTION FAILED in %m: sig != %b [original value %b] in line %0d", val, sig, `__LINE__); \
        $finish; \
    end \
$display("%s Passed!",op);

     