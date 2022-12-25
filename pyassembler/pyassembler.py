import instructions
from utils import BRANCH_INSTRUCTIONS, AsmSyntaxError
import argparse
import re
import macros


class Assembler:
    def __init__(self, file_path, output_file_path):
        self.file_path = file_path
        self.output_file_path = output_file_path

        self.labels = {}
        self.assembled_program = []
        self.expanded_program = []
        self.program_lines = []

        self.expand_macros()
        self.read_program_lines()
        self.parse_labels()
        self.assemble_program()
        self.write_program()

    def expand_macros(self):
        with open(self.file_path) as source:
            for num, line in enumerate(source.readlines()):
                striped_line = line.strip()
                if len(striped_line) and striped_line[0] == '#':
                    if not re.fullmatch(r'#[a-zA-Z]\w*\(.*\)', striped_line):
                        print("Invalid macro call at line %d." % num)
                        exit(1)

                    macro = re.split(r'\(.*\)', striped_line)[0][1:].strip()
                    params = striped_line.split('(')[1].replace(')', '').split(',')
                    params = tuple(p.strip() for p in params)
                    try:
                        macro_func = getattr(macros, macro.lower())
                        self.expanded_program.extend(macro_func(*params))
                    except AttributeError:
                        print("Undefined macro '%s' at line %d." % (macro.upper(), num))
                        exit(1)
                    except AsmSyntaxError as e:
                        print('Syntax error at line %s:' % num, e)
                        exit(1)
                else:
                    self.expanded_program.append(line)

    def read_program_lines(self):
        for num, line in enumerate(self.expanded_program):
            # remove useless whitespace
            if not line.isspace() and line[0] != ';':
                self.program_lines.append((num + 1, line.strip()))

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

            if len(line) == 0 or line.isspace() or line[0] == ';':
                continue

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
                print('Syntax error at line %s:' % orig_num, e)
                exit(1)

    def write_program(self):
        new_lines = [line + '\n' for line in self.assembled_program[:-1]]
        new_lines.append(self.assembled_program[-1])

        with open(self.output_file_path, 'w') as out:
            out.writelines(new_lines)


if __name__ == '__main__':
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('src')
    arg_parser.add_argument('-o', '--output_file', default='memfile.dat')

    cmd_args = arg_parser.parse_args()
    assembler = Assembler(cmd_args.src, cmd_args.output_file)
