import inspect
import re

from utils import AsmSyntaxError


def mov_word(*params):
    if len(params) != 2:
        raise AsmSyntaxError(f'{inspect.currentframe().f_code.co_name.upper()} macro expects 2 parameters not '
                             f'{len(params)} (%s).' % str(params).replace('[', '').replace(']', ''))

    if type(params[0]) != str or params[0].upper() not in ['X', 'Y']:
        raise AsmSyntaxError(f'{inspect.currentframe().f_code.co_name.upper()} macro expects the first parameter '
                             f'to be a register.')

    if not re.fullmatch(r'^\$(\d|[A-Fa-f]){4}$', params[1]):
        raise AsmSyntaxError(f"{inspect.currentframe().f_code.co_name.upper()} macro expects the second parameter "
                             f"to be a 16 bit numeric immediate starting with '$'.")

    high_byte = params[1][0:3]
    low_byte = '$' + params[1][3:]
    return [f'MOV {params[0]}, {high_byte}', f'LSLI {params[0]}, $08', f'ADDI {params[0]}, {low_byte}']


if __name__ == '__main__':
    mov_word()
