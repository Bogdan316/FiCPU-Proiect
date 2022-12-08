from abstract_instructions import MemoryInstruction, RegisterInstruction, BranchInstruction, SingleRegisterInstruction
from utils import decode_register_address, AsmSyntaxError, get_immediate_value


class Ldx(MemoryInstruction):
    def __init__(self, params):
        super(Ldx, self).__init__(params, '000001', '000101')

    @property
    def register_address(self):
        return 0


class Ldy(MemoryInstruction):
    def __init__(self, params):
        super(Ldy, self).__init__(params, '000001', '000101')

    @property
    def register_address(self):
        return 1


class Stx(MemoryInstruction):
    def __init__(self, params):
        super(Stx, self).__init__(params, '000010', None)

    @property
    def register_address(self):
        return 0


class Sty(MemoryInstruction):
    def __init__(self, params):
        super(Sty, self).__init__(params, '000010', None)

    @property
    def register_address(self):
        return 1


class Bra(BranchInstruction):
    @property
    def op_code(self):
        return '000110'


class Brz(BranchInstruction):
    @property
    def op_code(self):
        return '000111'


class Brn(BranchInstruction):
    @property
    def op_code(self):
        return '001000'


class Brc(BranchInstruction):
    @property
    def op_code(self):
        return '001001'


class Bro(BranchInstruction):
    @property
    def op_code(self):
        return '001010'


class Add(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '100000'


class Sub(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '100001'


class Psh(SingleRegisterInstruction):

    @property
    def op_code(self):
        return '000011'


class Pop(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '000100'


class Mva(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '100110'


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
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects 1 parameter not {len(self.params)} '
                                 f'(%s).' % str(self.params).replace('[', '').replace(']', ''))

        if type(self.params[0]) != str and self.params[0].upper() not in ['X', 'Y']:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects the first parameter to be a register.')

        if self.params[1][0] != '$':
            raise AsmSyntaxError(f"{self.__class__.__name__} instruction expects the second parameter to be a "
                                 f"numeric immediate starting with '$'.")

        self.immediate = get_immediate_value(self.params[1])

    def __str__(self):
        return f'{self.op_code}_{self.register_address}_{self.immediate:09b}'
