library(argparse)

# Define argument parser
parser <- ArgumentParser(description="Process dataset files")

# Add arguments
parser$add_argument("--output_dir", "-o", dest="output_dir", type="character", help="output directory where files will be saved")
parser$add_argument("--name", "-n", dest="name", type="character", help="name of the dataset")
parser$add_argument("--input_files", "-i", dest="input_files", type="character", help="input files to be processed")
parser$add_argument("-a", "--arg_a", dest="arg_a", help="extra argument a", default="0")
parser$add_argument("-b", "--arg_b", dest="arg_b", help="extra argument b", default="0")

# Parse command-line arguments
opt <- parser$parse_args()

# Check if mandatory arguments are provided
if (is.null(opt$output_dir) || is.null(opt$name)) {
  stop("Error: Mandatory arguments --output_dir, --name and --input-files are required.")
}

output_dir <- opt$output_dir
name <- opt$name
input_files <- unlist(strsplit(opt$input_files, ","))
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