## Verilog Serial USART — Transmitter & Receiver

**Tools:** Quartus / ModelSim  
**Language:** Verilog HDL  

### What it does
Implements a synchronous serial communication protocol
with parity error detection.

**Transmitter:**
- Parallel to serial conversion via shift register
- XOR parity bit generation
- Two send detection modes (PART1/PART2)
- PART2 handles async send with clock domain crossing

**Receiver:**
- Serial to parallel conversion
- Parity verification with ParErr flag
- PDready signal on successful receive

### Key concepts
- Shift register based serial communication
- Clock domain crossing (async signal synchronization)
- XOR parity generation and verification
- Finite state machine (busy/idle)
