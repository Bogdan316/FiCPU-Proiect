import instructions
import argparse

if __name__ == '__main__':
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument('src')

    args = arg_parser.parse_args()
    assembled_prog = []

    with open(args.src) as source_file:
        for idx, line in enumerate(source_file.readlines()):
            line = line.strip()
            if not len(line):
                continue
            instr, *params = line.split(' ')
            params = [p for p in params if len(p)]

            instr_class = getattr(instructions, instr.title())
            instr_ob = instr_class(*params)
            assembled_prog.append(f'{str(instr_ob)}\n')

    with open('memfile.dat', 'w') as dst_file:
        dst_file.writelines(assembled_prog)
