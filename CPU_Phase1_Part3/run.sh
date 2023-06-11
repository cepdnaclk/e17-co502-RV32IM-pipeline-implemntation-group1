#!/bin/bash
echo "cpu-pipeline test bench run start!"
echo ""

# Navigate to reg-file module directory
cd CPU

# if any error happens exit
set -e

# clean
rm -rf cpu_tb.vvp
rm -rf cpu_pipeline_wavedata.vcd

# compiling
iverilog -o cpu_tb.vvp cpu_tb.v

# run
vvp cpu_tb.vvp

echo ""
echo "cpu-pipeline test bench run stopped!"