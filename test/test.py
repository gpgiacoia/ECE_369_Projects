def replace_x(split):
    return split.replace('x', '0').replace('X', '0')


def to_twos_complement(val, bits):
    """compute the 2's complement of int value val"""
    if (val & (1 << (bits - 1))) != 0: # if sign bit is set e.g., 8bit: 128-255
        val = val - (1 << bits)        # compute negative value
    return val                         # return positive value as is


def test_log(is_pass: bool, pc: int, alu_type: str, op: str):
    if is_pass:
        print(f"\tPASS PC={pc} - {alu_type} - {op}")
    else:
        print(f"\tFAIL PC={pc} - {alu_type} - {op}")


def alu_type(pc: int, op: str, a: int, b: int, r: int, eq: str):
    try:
        match op:
            # TODO: check dest
            case "ADD":
                test_log(a + b == r, pc, op, eq)
            case "SUB":
                test_log(a - b == r, pc, op, eq)
            case "AND":
                test_log(a & b == r, pc, op, eq)
            case "OR":
                test_log(a | b == r, pc, op, eq)
            case "NOR":
                test_log(~(a | b) == r, pc, op, eq)
            case "XOR":
                test_log(a ^ b == r, pc, op, eq)
            case "SLL":
                test_log(b << a == r, pc, op, f"{b} << {a} == {r}")
            case "SRL":
                test_log(b >> a == r, pc, op, f"{b} >> {a} == {r}")
            case "SLT":
                test_log(a < b == r, pc, op, eq)
            case "JAL":
                # TODO: check new PC
                test_log(r == 0, pc, op, eq)
            case "ADDI":
                test_log(a + b == r, pc, op, eq)
            case "ANDI":
                test_log(a & b == r, pc, op, eq)
            case "ORI":
                test_log(a | b == r, pc, op, eq)
            case "XORI":
                test_log(a ^ b == r, pc, op, eq)
            case "SLTI":
                test_log(a < b == r, pc, op, eq)
            # TODO: check mem
            case "LW":
                test_log(a + b == r, pc, op, eq)
            case "SW":
                test_log(a + b == r, pc, op, eq)
            case "SB":
                test_log(a + b == r, pc, op, eq)
            case "LH":
                test_log(a + b == r, pc, op, eq)
            case "LB":
                test_log(a + b == r, pc, op, eq)
            case "SH":
                test_log(a + b == r, pc, op, eq)
            case "BGEZ":
                test_log((a >= 0) == r, pc, op, eq)
            case "BEQ":
                test_log((a == b) == r, pc, op, eq)
            case "BNE":
                test_log((a != b) == r, pc, op, eq)
            case "BGTZ":
                test_log((a > 0) == r, pc, op, eq)
            case "BLEZ":
                test_log((a <= 0) == r, pc, op, eq)
            case "BLTZ":
                test_log((a < 0) == r, pc, op, eq)
            # TODO: check new PC
            case "J":
                test_log(r == 0, pc, op, eq)
            case "JR":
                test_log(r == 0, pc, op, eq)
            case "MUL":
                test_log(a * b == r, pc, op, eq)
            case _:
                print("UNKNOWN OP: ", op)
                exit(-2)
    except ValueError:
        print("Invalid operand")


def main():
    file = open("simulate.log", "r")
    next(file)  # skip time resolution

    time_last = 0
    pc = 0
    instruction = 0
    reg = ""
    reg_val = 0
    mem_write = 0
    mem_read = 0
    i = 0

    for line in file:
        split = line.split()
        split.pop(1)

        time = int(split.pop(0).split('=').pop(1))
        # print(f"time: {time}, time_last: {time_last}")

        if time != time_last:
            time_last = time

        # if time > 4150000:
        #     return

        # print(f"{i}: {line}")
        i += 1

        log_type = split.pop(0)
        match log_type:
            case "PC":
                pc = int(
                    replace_x(split.pop(1)),
                    16
                )
                print("PC: ", pc)
            case "Instruction":
                instruction = int(
                    replace_x(split.pop(1)),
                    2
                )
                print("Instruction: ", instruction)
            case "REG":
                reg = split.pop(0)
                reg_val = int(
                    replace_x(split.pop(1)),
                    16
                )
                print(f"REG {reg} = {reg_val}")
            case "DATA_MEM_WRITE":
                mem_write = int(
                    replace_x(split.pop(1)),
                    16
                )
                print("MEM WRITE: ", mem_write)
            case "DATA_MEM_READ":
                mem_read = int(
                    replace_x(split.pop(1)),
                    16
                )
                print("MEM READ: ", mem_read)
            case "CTRL_NOP":
                print("NOP")
            case "ALU":
                # TODO: Group based on same time and set PC
                # use time_last
                # TODO: Get dest reg from instruction and mem
                # TODO: FIX BUG IN CPU
                # on this instruction, B in ALU is 0 instead of -1
                # likely caused by sign extend or something
                # t=690000 - Instruction = 0b00100010000100001111111111111111
                # t=730000 - ALU ADDI RT: 0b0 0x00000000 + 0x00000000 = 0x00000000
                # should be 0 + -1 = -1

                alu_instruction = split.pop(0)
                r_type = int(
                    replace_x(split.pop(1)),
                    2
                )
                a = to_twos_complement(int(
                    replace_x(split.pop(1)),
                    16
                ), 32)
                op = split.pop(1)
                b = to_twos_complement(int(
                    replace_x(split.pop(1)),
                    16
                ), 32)
                result = to_twos_complement(int(
                    replace_x(split.pop(2)),
                    16
                ), 32)
                print(
                    f"ALU {
                        ('{:032b}'.format(instruction))
                        }: R={r_type} {a} {op} {b} = {result}"
                )
                alu_type(
                    pc,
                    alu_instruction,
                    a,
                    b,
                    result,
                    f"{a} {op} {b} = {result}"
                )
            case _:
                print("Unknown log type: ", log_type)
                exit(-1)


if __name__ == "__main__":
    main()
