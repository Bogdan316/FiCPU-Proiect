class AsmSyntaxError(Exception):
    def __init__(self, message):
        super().__init__(message)


BRANCH_INSTRUCTIONS = ('BRZ', 'BRN', 'BRC', 'BRO', 'BRA', 'JMP')


def get_immediate_memory_addr(imm):
    assert '#' in imm
    # convert from hex and word align
    imm = int(imm.replace('#', ''), 16) << 1
    assert imm < 512
    return imm


def get_immediate_value(imm):
    assert '$' in imm
    # convert from hex
    imm = int(imm.replace('$', ''), 16)
    assert imm < 512
    return imm


def decode_register_address(symbol):
    assert len(symbol) == 1 and symbol.lower() in ['x', 'y']
    symbol = symbol.lower()
    return int(symbol == 'y')