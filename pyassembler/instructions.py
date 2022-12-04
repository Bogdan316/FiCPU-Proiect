from abc import ABC, abstractmethod


class AsmSyntaxError(Exception):
    def __init__(self, message):
        super().__init__(message)


BRANCH_INSTRUCTIONS = ('BRZ', 'BRN', 'BRC', 'BRO', 'BRA', 'JMP')


def get_immediate_memory_addr(imm):
    assert '#' in imm
    # convert from hex and word align
    imm = int(imm.replace('#', ''), 16) << 1
    assert imm < 255
    return imm


def get_immediate_value(imm):
    assert '$' in imm
    # convert from hex
    imm = int(imm.replace('$', ''), 16)
    assert imm < 255
    return imm


def decode_register_address(symbol):
    assert len(symbol) == 1
    symbol = symbol.lower()
    return int(symbol == 'y')


class SimpleInstruction(ABC):

    def __init__(self, params):
        self.params = params
        self.parse()

    @property
    @abstractmethod
    def op_code(self):
        raise NotImplementedError("op_code method is abstract.")

    @abstractmethod
    def parse(self):
        raise NotImplementedError("parse method is abstract.")


class RegisterInstruction(SimpleInstruction, ABC):
    def __init__(self, params):
        super().__init__(params)

    @property
    @abstractmethod
    def register_address(self):
        raise NotImplementedError("register_address method is abstract.")


class MemoryInstruction(RegisterInstruction, ABC):
    def __init__(self, params):
        self.immediate = None
        super().__init__(params)

    @property
    def op_code(self):
        return '000001'

    def parse(self):
        if len(self.params) != 1:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects 1 parameter not {len(self.params)}.')

        if self.params[0][0] != '#':
            raise AsmSyntaxError(f"{self.__class__.__name__} instruction expects an address starting with '#'.")

        self.immediate = get_immediate_memory_addr(self.params[0])

    def __str__(self):
        return f'{self.op_code}_{self.register_address}_{self.immediate:09b}'


class Ldx(MemoryInstruction):
    @property
    def register_address(self):
        return 0


class Ldy(MemoryInstruction):
    @property
    def register_address(self):
        return 1


class Stx(MemoryInstruction):
    @property
    def register_address(self):
        return 0


class Sty(MemoryInstruction):
    @property
    def register_address(self):
        return 1


class Mov(RegisterInstruction):

    def __init__(self, params):
        self.immediate = None
        super().__init__(params)

    @property
    def register_address(self):
        return decode_register_address(self.params[0])

    @property
    def op_code(self):
        return '100111'

    def parse(self):
        if len(self.params) != 2:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects 2 parameters not {len(self.params)}.')

        if type(self.params[0]) != str and self.params[0].upper() not in ['X', 'Y']:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects the first parameter to be a register.')

        if self.params[1][0] != '$':
            raise AsmSyntaxError(f"{self.__class__.__name__} instruction expects numeric immediate starting with '$'.")

        self.immediate = get_immediate_value(self.params[1])

    def __str__(self):
        return f'{self.op_code}_{self.register_address}_{self.immediate:09b}'


class Bra(SimpleInstruction):

    def __init__(self, params):
        self.immediate = None
        super().__init__(params)

    @property
    def op_code(self):
        return '000110'

    def parse(self):
        if len(self.params) != 3:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects 1 parameter not {len(self.params)}.')
        instr_line = self.params[0]
        labels_dict = self.params[1]
        label = self.params[2]
        self.immediate = labels_dict[label] - instr_line
        if self.immediate < 0:
            pass
        else:
            self.immediate = get_immediate_value(f'${self.immediate - 1}')

    def __str__(self):
        return f'{self.op_code}_{self.immediate:010b}'
#
#
# class Add:
#     def __init__(self, *args):
#         assert len(args) == 2
#         self.reg_addr = decode_register_address(args[0])
#         self.imm = get_immediate_value(args[1])
#
#     def __str__(self):
#         return f'100000_{self.reg_addr}_{self.imm:09b}'
#
#
# class Sub:
#     def __init__(self, *args):
#         assert len(args) == 2
#         self.reg_addr = decode_register_address(args[0])
#         self.imm = get_immediate_value(args[1])
#
#     def __str__(self):
#         return f'100001_{self.reg_addr}_{self.imm:09b}'
#
#
# class Psh:
#     def __init__(self, *args):
#         assert len(args) == 1
#         self.reg_addr = decode_register_address(args[0])
#
#     def __str__(self):
#         return f'000011_{self.reg_addr}_{0:09b}'
#
#
# class Pop:
#     def __init__(self, *args):
#         assert len(args) == 1
#         self.reg_addr = decode_register_address(args[0])
#
#     def __str__(self):
#         return f'000100_{self.reg_addr}_{0:09b}'
#
#
# class Mva:
#     def __init__(self, *args):
#         assert len(args) == 1
#         self.reg_addr = decode_register_address(args[0])
#
#     def __str__(self):
#         return f'100110_{self.reg_addr}_{0:09b}'
