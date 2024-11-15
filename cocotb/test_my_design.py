# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# test_my_design.py (simple)

import cocotb
from cocotb.triggers import Timer
from cocotb.triggers import FallingEdge, Timer

CLK = 10

async def generate_clock(dut, nanos):
    """Generate clock pulses."""

    for cycle in range(nanos):
        dut.Clk.value = 0
        await Timer(CLK, units="ns")
        dut.Clk.value = 1
        await Timer(CLK, units="ns")


async def generate_reset(dut):
    """Generate reset pulse over 90ns."""
    dut.Reset.value = 1
    await Timer(CLK * 9, units="ns")
    dut.Reset.value = 0


async def tick_cycle(dut):
    await Timer(CLK * 2)
    await FallingEdge(dut.Clk)


@cocotb.test()
async def my_first_test(dut):
    """Try accessing the design."""
    await cocotb.start(generate_clock(dut, 500))  # run the clock "in the background"
    await cocotb.start(generate_reset(dut))
    await Timer(CLK * 9, units="ns") # wait for reset to become unset
    await FallingEdge(dut.Clk)  # wait for falling edge/"negedge"

    assert dut.Instruction.value.to_unsigned() == 0x20080000    # addi $t0, $zero, 0 == 0
    await tick_cycle(dut)   # F (addi $t0, $zero, 0) | D (none) | E (none) | M (none) | W (none)
    assert dut.Instruction.value.to_unsigned() == 0x20090001    # addi $t1, $zero, 1 == 1
    await tick_cycle(dut)   # F (addi $t1, $zero, 1) | D (addi $t0, $zero, 0) | E (none) | M (none) | W (none)
    assert dut.Instruction.value.to_unsigned() == 0x00094a00    # sll $t1, $t1, 8    == 256
    await tick_cycle(dut)	# F (sll $t1, $t1, 8) | D (addi $t1, $zero, 1) | E (addi $t0, $zero, 0) | M (none) | W (none)
    assert dut.Instruction.value.to_unsigned() == 0x00094a00    # sll $t1, $t1, 8    == 65536
    assert dut.registerFile.registers[8].value.to_unsigned() == 0
    await tick_cycle(dut)	# F (sll $t1, $t1, 8) | D (sll $t1, $t1, 8) | E (addi $t1, $zero, 1) | M (none) | W (none)
    assert dut.registerFile.registers[9].value.to_unsigned() == 1
    await tick_cycle(dut)	# F (none) | D (sll $t1, $t1, 8) | E (sll $t1, $t1, 8) | M (none) | W (none)
    await tick_cycle(dut)	# F (none) | D (sll $t1, $t1, 8) | E (none) | M (sll $t1, $t1, 8) | W (none)
    await tick_cycle(dut)	# F (none) | D (sll $t1, $t1, 8) | E (none) | M (none) | W (sll $t1, $t1, 8)
    assert dut.registerFile.registers[9].value.to_unsigned() == 256
    await tick_cycle(dut)	# F (none) | D (none) | E (sll $t1, $t1, 8) | M (none) | W (none)
    await tick_cycle(dut)	# F (none) | D (none) | E (none) | M (sll $t1, $t1, 8) | W (none)
    await tick_cycle(dut)	# F (none) | D (none) | E (none) | M (none) | W (sll $t1, $t1, 8)
    assert dut.registerFile.registers[9].value.to_unsigned() == 65536
