#!/bin/bash
echo "cpu-pipeline test bench run start!"
echo ""
cd CPU
set -e
rm -rf cpu_tb.vvp
rm -rf cpu_pipeline_wavedata.vcd
iverilog -o cpu_tb.vvp cpu_tb.v
vvp cpu_tb.vvp
echo ""
echo "cpu-pipeline test bench run stopped!"