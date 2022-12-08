import re
from abc import ABC, abstractmethod
from bitstring import Bits

from utils import AsmSyntaxError, get_immediate_memory_addr, decode_register_address, get_immediate_value


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
    def __init__(self, params, mem_op_code, reg_op_code):
        self.immediate = None
        self._op_code = None
        self.mem_op_code = mem_op_code
        self.reg_op_code = reg_op_code
        super().__init__(params)

    @property
    def op_code(self):
        return self._op_code

    def parse(self):
        if len(self.params) != 1:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects 1 parameter not {len(self.params)} '
                                 f'(%s).' % str(self.params).replace('[', '').replace(']', ''))

        if re.fullmatch(r'^#([0-9]|[A-Fa-f]){2}$', self.params[0]):
            self.immediate = get_immediate_memory_addr(self.params[0])
            self._op_code = self.mem_op_code
        elif re.fullmatch(r'^\(([x,X]|[y|Y])\)$', self.params[0]):
            self.immediate = decode_register_address(self.params[0][1])
            self._op_code = self.reg_op_code
        else:
            raise AsmSyntaxError(f"{self.__class__.__name__} instruction expects an address starting with '#' or "
                                 f"a register name surrounded by '()'.")

    def __str__(self):
        return f'{self.op_code}_{self.register_address}_{self.immediate:09b}'


class BranchInstruction(SimpleInstruction, ABC):

    def __init__(self, params):
        self.immediate = None
        super().__init__(params)

    def parse(self):
        if len(self.params) != 3:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects 1 parameter not {len(self.params)} '
                                 f'(%s).' % str(self.params).replace('[', '').replace(']', ''))

        instr_line = self.params[0]
        labels_dict = self.params[1]
        label = self.params[2]

        if label not in labels_dict:
            raise AsmSyntaxError(f'{self.__class__.__name__} undefined label %s.' % label)

        self.immediate = labels_dict[label] - instr_line
        if self.immediate < 0:
            # convert to C2
            self.immediate = Bits(int=self.immediate, length=10).bin
        else:
            self.immediate = get_immediate_value(f'${self.immediate - 1}')

    def __str__(self):
        if type(self.immediate) == str:
            return f'{self.op_code}_{self.immediate}'
        else:
            return f'{self.op_code}_{self.immediate:010b}'


class SingleRegisterInstruction(RegisterInstruction, ABC):
    @property
    def register_address(self):
        return decode_register_address(self.params[0])

    def parse(self):
        if len(self.params) != 1:
            raise AsmSyntaxError(f'{self.__class__.__name__} instruction expects 1 parameter not {len(self.params)} '
                                 f'(%s).' % str(self.params).replace('[', '').replace(']', ''))

        if self.params[0].upper() not in ['X', 'Y']:
            raise AsmSyntaxError(f'{self.__class__.__name__} expects a register as its parameter.')

    def __str__(self):
        return f'{self.op_code}_{self.register_address}_000000000'
