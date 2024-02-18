GMT File Gene Name Replacement
Task Overview:
The goal of this program is to create a new GMT file by replacing gene names with their corresponding Entrez IDs. The necessary information is obtained from two input files: Homo_sapiens.gene_info.gz and h.all.v2023.1.Hs.symbols.gmt.

Data:
Homo_sapiens.gene_info.gz:

A tab-delimited text file containing gene information for the human genome.
Relevant columns: GeneID (Entrez Id), Symbol, and Synonyms.
Create a mapping of Symbol to GeneId, considering multiple symbols in the Synonyms column.
Reference: NCBI Gene Info README

h.all.v2023.1.Hs.symbols.gmt:

A gene matrix transposed file used for pathway analysis.
Each line represents a pathway with the first two values being "pathway name" and "pathway description," followed by gene names.
Program Specifications:
Symbol to GeneId Mapping:

Read Homo_sapiens.gene_info.gz and create a comprehensive mapping of all gene (symbol) names to their corresponding Entrez IDs.
Consider both the Symbol and Synonyms columns for inclusive mapping.
GMT File Processing:

Read h.all.v2023.1.Hs.symbols.gmt line by line.
Replace gene names with their corresponding Entrez IDs obtained from the mapping created in step 1.
Output:

Write a new GMT file where gene symbols have been replaced with Entrez IDs.
The new file can be printed in the terminal or saved as a separate file.
