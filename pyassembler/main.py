import instructions
from utils import BRANCH_INSTRUCTIONS, AsmSyntaxError
import argparse
import re


class Assembler:
    def __init__(self, file_path):
        self.file_path = file_path
        self.labels = {}
        self.assembled_program = []

        self.program_lines = self.read_program_lines()
        self.parse_labels()
        self.assemble_program()
        self.write_program()

    def read_program_lines(self):
        program_lines = []
        with open(self.file_path) as source:
            for num, line in enumerate(source.readlines()):
                # remove useless whitespace
                if not line.isspace():
                    program_lines.append((num + 1, line.strip()))

        return program_lines

    def parse_labels(self):
        for num, line in enumerate(map(lambda t: t[1], self.program_lines)):
            if ':' not in line:
                continue
            label, instr = line.split(':')

            if (label and not instr) or (not label and instr):
                print("Invalid use of ':' at line %d, the label and the instruction should be on the same line." % num)
                exit(1)

            self.labels[label] = num

    def assemble_program(self):
        for num, (orig_num, line) in enumerate(self.program_lines):
            tokens = [symbol for symbol in re.split(r':|\s|,', line) if symbol]

            if ':' in line:
                label, instr, *params = tokens
            else:
                instr, *params = tokens

            if instr.upper() in BRANCH_INSTRUCTIONS:
                params = (num, self.labels, *params)

            try:
                instr_class = getattr(instructions, instr.title())
                instr_ob = instr_class(params)
                self.assembled_program.append(str(instr_ob))
            except AttributeError:
                print("Undefined instruction '%s' at line %d." % (instr.upper(), orig_num))
                exit(1)
            except AsmSyntaxError as e:
                print('Syntax error at line %s:' % num, e)
                exit(1)

    def write_program(self):
        new_lines = [line + '\n' for line in self.assembled_program[:-1]]
        new_lines.append(self.assembled_program[-1])

        with open('memfile.dat', 'w') as out:
            out.writelines(new_lines)


if __name__ == '__main__':
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('src')

    cmd_args = arg_parser.parse_args()
    assembler = Assembler(cmd_args.src)
