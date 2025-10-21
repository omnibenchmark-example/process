import argparse
import os


def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Process dataset files")

    # Define arguments
    parser.add_argument("--output_dir", "-o", dest="output_dir", type=str, help="output directory where files will be saved", required=True)
    parser.add_argument("--name", "-n", dest="name", type=str, help="name of the dataset", required=True)
    parser.add_argument("--data.counts", dest="data_counts", type=str, help="input file #1")
    parser.add_argument("--data.meta", dest="data_meta", type=str, help="input file #2")
    parser.add_argument("-a", "--a", dest="arg_a", type=float, default=0, help="extra argument a")
    parser.add_argument("-b", "--b", dest="arg_b", type=float, default=0, help="extra argument b")

    # Parse arguments
    args = parser.parse_args()

    output_dir = args.output_dir
    name = args.name
    data_counts_input = args.data_counts
    data_meta_input = args.data_meta
    input_files = [f for f in [data_counts_input, data_meta_input] if f]
    a = args.arg_a
    b = args.arg_b

    # Read and combine content from input files
    processed_content = []
    for input_file in input_files:
        with open(input_file, 'r') as f:
            processed_content.extend(f.readlines())

    # Append the module message
    module_message = f"\n2. Preprocessing dataset files using parameters '-a {a} -b {b}' into {os.path.join(output_dir, name)}.txt.gz\n"
    processed_content.append(module_message)

    # Write output to gzipped file
    output_path = os.path.join(output_dir, f"{name}.processed.txt.gz")
    with open(output_path, 'wt') as out_file:
        out_file.writelines(processed_content)


if __name__ == "__main__":
    main()
