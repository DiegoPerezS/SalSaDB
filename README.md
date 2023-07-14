# SalSaDB
A small database that links several Gene Identifiers from Atlantic salmon
This is a collaborative Database, which means that the users are free to improve the scope of this database and are free to use the scripts to do so. Any contribution is welcome and must include a README file and the script used to obtain the dataset.

Database details:

-NCBI-TID_to_MiID.txt: 
Microarray ID (PID) conversion to Transcript ID (TID) from NCBI

-NCBI_Gene_symbol_product_ENSEMBL.txt: 
NCBI GeneID (GID) attributes of Gene_symbol and product. The column Assigned_Gene_symbol contains the information manually curated for the differentially expressed genes in this study, while the column Gene_symbol corresponds to the automatically assigned Gene symbols. The Product column, specifically for manually curated genes, it can be found in more than one product separated by ";", which corresponds to the product specified in the ENSEMBL database. We also included the ENSEMBL_GID column as some of the equivalences for NCBI_GID were not found, but in the manually curated information, we conserved those genes as there was information available in the ENSEMBL database.

-NCBI_to_ENSEMBL.txt: 
NCBI GID equivalence in ENSEMBL database as ENSEMBL GID, this table also contains the information for our manually curated GIDs, which is specified in the column "Assignation" that specifies if it were assigned automatically, or the specific database from it was assigned. The last column, Overlap, indicates the overlap between the NCBI gene and the ENSEMBL gene, in which a partial overlap corresponds to most intron overlap that could or not overlap in the gene start codon; if the overlap of the introns of the NCBI gene was contained between the introns of the ENSEMBL gene and the gene start codon of both genes was in the same region (+/- 1000 bp), the overlap is indicated as "yes".

-NCBI-GID_to_TID_to_Accession.txt: 
NCBI GID conversion to TID without the version of the transcript. This table contains all the alternative splicing transcripts for each gene.
