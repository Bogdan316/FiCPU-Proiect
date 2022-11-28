from abc import ABC, abstractmethod


def get_imm_memory_addr(imm):
    assert '#' in imm
    # convert from hex and word align
    imm = int(imm.replace('#', ''), 16) << 1
    assert imm < 255
    return imm


def get_imm_value(imm):
    assert '$' in imm
    # convert from hex
    imm = int(imm.replace('$', ''), 16)
    assert imm < 255
    return imm


def dec_reg_addr(symbol):
    assert len(symbol) == 1
    symbol = symbol.lower()
    return int(symbol == 'y')


class Ld(ABC):
    def __init__(self, *args):
        assert len(args) == 1
        self.imm = get_imm_memory_addr(args[0])

    @property
    @abstractmethod
    def reg_addr(self):
        pass

    def __str__(self):
        return f'000001_{self.reg_addr}_{self.imm:09b}'


class Ldx(Ld):
    @property
    def reg_addr(self):
        return 0


class Ldy(Ld):
    @property
    def reg_addr(self):
        return 1


class St(ABC):
    def __init__(self, *args):
        assert len(args) == 1
        self.imm = get_imm_memory_addr(args[0])

    @property
    @abstractmethod
    def reg_addr(self):
        pass

    def __str__(self):
        return f'000010_{self.reg_addr}_{self.imm:09b}'


class Stx(St):
    @property
    def reg_addr(self):
        return 0


class Sty(St):
    @property
    def reg_addr(self):
        return 1


class Add:
    def __init__(self, *args):
        assert len(args) == 2
        self.reg_addr = dec_reg_addr(args[0])
        self.imm = get_imm_value(args[1])

    def __str__(self):
        return f'100000_{self.reg_addr}_{self.imm:09b}'


class Sub:
    def __init__(self, *args):
        assert len(args) == 2
        self.reg_addr = dec_reg_addr(args[0])
        self.imm = get_imm_value(args[1])

    def __str__(self):
        return f'100001_{self.reg_addr}_{self.imm:09b}'


class Psh:
    def __init__(self, *args):
        assert len(args) == 1
        self.reg_addr = dec_reg_addr(args[0])

    def __str__(self):
        return f'000011_{self.reg_addr}_{0:09b}'


class Pop:
    def __init__(self, *args):
        assert len(args) == 1
        self.reg_addr = dec_reg_addr(args[0])

    def __str__(self):
        return f'000100_{self.reg_addr}_{0:09b}'


class Mva:
    def __init__(self, *args):
        assert len(args) == 1
        self.reg_addr = dec_reg_addr(args[0])

    def __str__(self):
        return f'100110_{self.reg_addr}_{0:09b}'
