##Step 1: Install and load the required packages.
install.packages(c("biomaRt", "data.table"))
library(biomaRt)
library(data.table)

## Step 2: Read gene_info file and extract relevant columns.
# Path to the gzipped gene_info file
gene_info_file_path <- "Homo_sapiens.gene_info.gz"
# Read the gzipped file using fread from data.table
gene_info_data <- fread(gene_info_file_path, header = FALSE, quote = "")
# Extract relevant columns (GeneID, Symbol, Synonyms)
gene_info_data <- gene_info_data[, c(2, 3, 5), with = FALSE]
setnames(gene_info_data, c("GeneID", "Symbol", "Synonyms"))


##Step 3: Create Symbol to GeneID mapping.
## Create Symbol to GeneID mapping
symbol_geneid_mapping <- data.table::data.table(
GeneID = rep(gene_info_data$GeneID, lengths(strsplit(gene_info_data$Synonyms, "\\|"))),
Symbol = unlist(strsplit(gene_info_data$Synonyms, "\\|"))
)


## Step 4: Read GMT file line by line and replace gene symbols with Entrez IDs.
gmt_file_path <- "h.all.v2023.1.Hs.symbols.gmt"
gmt_data <- readLines(gmt_file_path)

# Create a dictionary for mapping
mapping_dict <- setNames(symbol_geneid_mapping$GeneID, symbol_geneid_mapping$Symbol)

### Replace gene symbols with Entrez IDs in GMT data
gmt_data_entrez <- lapply(gmt_data, function(line) {
     fields <- strsplit(line, "\t")[[1]]
     pathway_genes <- fields[-c(1, 2)] ## Exclude the pathway name and description
     
# Replace gene symbols with Entrez IDs
entrez_ids <- mapping_dict[match(pathway_genes, names(mapping_dict))]
fields[-c(1, 2)] <- ifelse(is.na(entrez_ids), pathway_genes, as.character(entrez_ids))

#Concatenate the fields and return the modified line
return(paste(fields, collapse = "\t"))
})

gmt_data_entrez <- sapply(gmt_data_entrez, as.character)
gmt_output_file <- gsub(".gmt", "_entrez.gmt", gmt_file_path, ignore.case = TRUE)
writeLines(gmt_data_entrez, gmt_output_file)
cat("GMT file with Entrez IDs has been created:", gmt_output_file, "\n")
gmt_data_entrez <- sapply(gmt_data_entrez, as.character)
gmt_output_file <- gsub(".gmt", "_entrez.gmt", gmt_file_path, ignore.case = TRUE)
writeLines(gmt_data_entrez, gmt_output_file)
cat("GMT file with Entrez IDs has been created:", gmt_output_file, "\n")
cat(readLines(gmt_output_file, n = 10), sep = "\n")




