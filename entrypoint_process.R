library(argparse)

# Define argument parser
parser <- ArgumentParser(description="Process dataset files")

# Add arguments
parser$add_argument("--output_dir", "-o", dest="output_dir", type="character", help="output directory where files will be saved")
parser$add_argument("--name", "-n", dest="name", type="character", help="name of the dataset")
parser$add_argument("--data.counts", dest="data_counts", type="character", help="input file #1")
parser$add_argument("--data.meta", dest="data_meta", type="character", help="input file #2")
parser$add_argument("-a", dest="arg_a", help="extra argument a", default="0")
parser$add_argument("-b", dest="arg_b", help="extra argument b", default="0")

# Parse command-line arguments
opt <- parser$parse_args()

# Check if mandatory arguments are provided
if (is.null(opt$output_dir) || is.null(opt$name)) {
  stop("Error: Mandatory arguments --output_dir, --name and --input-files are required.")
}

output_dir <- opt$output_dir
name <- opt$name
data_counts_input <- opt$data_counts
data_meta_input <- opt$data_meta
input_files <- c(data_counts_input, data_meta_input)
a <- as.double(opt$arg_a)
b <- as.double(opt$arg_b)

# Combine content from all input files
processed_content <- character()
for (input_file in input_files) {
  # Read content of each input file
  file_content <- readLines(input_file)
  # Append content to the combined content vector
  processed_content <- c(processed_content, file_content)
}


# Write combined content to a file in the output directory
process_filtered_file <- file.path(output_dir, paste0(name, ".txt.gz"))

module_message <- paste("\n2. Preprocessing dataset files using parameters '-a", a, "-b", b, "' into", process_filtered_file)
processed_content <- c(processed_content, module_message)
writeLines(processed_content, process_filtered_file)