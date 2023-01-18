from abstract_instructions import MemoryInstruction, RegisterInstruction, BranchInstruction, SingleRegisterInstruction, \
    SimpleInstruction, RegisterAndImmediateInstruction
from utils import decode_register_address, AsmSyntaxError, get_immediate_value


class Hlt(SimpleInstruction):
    @property
    def op_code(self):
        return '000000'

    def parse(self):
        if len(self.params) != 0:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction does not expect any parameters not '
                                 f'{len(self.params)} (%s).' % str(self.params).replace('[', '').replace(']', ''))

    def __str__(self):
        return f'{self.op_code}_0_{0:09b}'


class Ret(SimpleInstruction):
    @property
    def op_code(self):
        return '001101'

    def parse(self):
        if len(self.params) != 0:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction does not expect any parameters not '
                                 f'{len(self.params)} (%s).' % str(self.params).replace('[', '').replace(']', ''))

    def __str__(self):
        return f'{self.op_code}_0_{0:09b}'


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
        super(Stx, self).__init__(params, '000010', '001011')

    @property
    def register_address(self):
        return 0


class Sty(MemoryInstruction):
    def __init__(self, params):
        super(Sty, self).__init__(params, '000010', '001011')

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


class Jmp(BranchInstruction):
    @property
    def op_code(self):
        return '001100'


class Add(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '100000'


class Sub(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '100001'


class Mul(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101000'


class Lsr(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101001'


class Lsl(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101010'


class Rsr(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101011'


class Rsl(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101100'


class Div(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101101'


class Mod(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101110'


class And(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '101111'


class Or(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110000'


class Xor(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110001'


class Not(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110010'


class Inc(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110011'


class Dec(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110100'


class Cmp(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110101'


class Tst(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110110'


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


class Mvr(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '110111'


class Mov(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '100111'


class Addi(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '111000'


class Subi(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '111001'


class Muli(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '111010'


class Lsri(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '111011'


class Lsli(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '111100'


class Divi(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '111101'


class Modi(RegisterAndImmediateInstruction):
    @property
    def op_code(self):
        return '111110'


class Fpadd(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '001110'


class Fpmul(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '001111'


class Fpsub(SingleRegisterInstruction):
    @property
    def op_code(self):
        return '010000'
