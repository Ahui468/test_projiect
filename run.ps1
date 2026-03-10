$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force "build" | Out-Null
& "iverilog" "-g2012" "-o" "build/sim.vvp" "testbench.v"
Push-Location "build"
& "vvp" "-n" "sim.vvp"
Pop-Location
& "gtkwave" "build/wave.vcd"

