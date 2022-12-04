import instructions
from instructions import BRANCH_INSTRUCTIONS, AsmSyntaxError
import argparse
import re


class Assembler:
    def __init__(self, file_path):
        self.file_path = file_path
        self.labels = {}

        self.program_lines = self.read_program_lines()
        self.parse_labels()
        self.assemble_program()

    def read_program_lines(self):
        program_lines = []
        with open(self.file_path) as source:
            for line in source.readlines():
                # remove useless whitespace
                if not line.isspace():
                    program_lines.append(line.strip())

        return program_lines

    def parse_labels(self):
        for num, line in enumerate(self.program_lines):
            if ':' not in line:
                continue
            label, instr = line.split(':')

            if (label and not instr) or (not label and instr):
                print("Invalid use of ':' at line %d, the label and the instruction should be on the same line." % num)
                exit(1)

            self.labels[label] = num

    def assemble_program(self):
        for num, line in enumerate(self.program_lines):
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
                print(instr_ob)
            except AttributeError:
                print("Undefined instruction '%s' at line %d." % (instr.upper(), num))
                exit(1)
            except AsmSyntaxError as e:
                print(e)
                exit(1)


if __name__ == '__main__':
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('src')

    cmd_args = arg_parser.parse_args()
    assembler = Assembler(cmd_args.src)
    # assembled_prog = []
    #
    # with open(args.src) as source_file:
    #     for idx, line in enumerate(source_file.readlines()):
    #         line = line.strip()
    #         if not len(line):
    #             continue
    #         instr, *params = line.split(' ')
    #         params = [p for p in params if len(p)]
    #
    #         instr_class = getattr(instructions, instr.title())
    #         instr_ob = instr_class(*params)
    #         assembled_prog.append(f'{str(instr_ob)}\n')
    #
    # with open('memfile.dat', 'w') as dst_file:
    #     dst_file.writelines(assembled_prog)
