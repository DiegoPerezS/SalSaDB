#!/usr/bin/perl
########################################################################
#
#	This script was created by Diego Pérez-Stuardo
#	File generated from part 1 of this script or:
#		Data frame with a list of NCBI gene IDs in one column
#
########################################################################

use strict;
use warnings;

#------Declarations-------

my $temp_dir = "../Genome/temp";		# Temporal directory to store the metadata, which will be deleted after its use
my $file = "NCBI_list.txt";				# Input File
my $GID = "";							# Empty, to save the NCBI gene ID
my $gfile = "";							# Empty, to indicate downloaded temp file
my $ENID = "";							# Empty, to save the ENSEMBL gene ID
my $ENID2 = "";							# Empty, in case the gene has two ENSEMBL gene ID associated in the temporal file
my $newfile = "NCBI_to_ENSEMBL.txt";	# Output file	

system "touch $newfile";
open (my $finalfh, '>', $newfile) or die "Can't open '$file' $!\n";
print $finalfh "NCBI_GID\tENSEMBL_GID\n";	# Print header of the NCBI to ENSEMBL gene ID conversion in the output file

open (my $fh, '<', $file) or die "Can't open '$file' $!\n";
while (my $line = <$fh>){
	chomp $line;
	if($line =~ /^(\d+)/){				# Identification of the NCBI gene ID from the input file
		$GID = $1;								
		#~ print "$GID\n";				# Print NCBI gene ID, helps to keep track of the progress
		# Download the NCBI report of the gene associated from the NCBI gene ID in the input file
		system "wget -q --show-progress -O $temp_dir/$GID.txt 'https://www.ncbi.nlm.nih.gov/gene/$GID?report=full_report&format=text'";
		print "$GID saved\n";			# Print NCBI saved gene ID file, helps to keep track of the progress
		$gfile = "$temp_dir/$GID.txt";	# Assignation of the downloaded file directory to a string
		# Open NCBI gene report
		open (my $fh2, '<', $gfile) or die "Can't open '$gfile' $!\n";
		while (my $ln = <$fh2>){
			chomp $ln;
			# Identify ENSEMBL gene ID within the NCBI gene report, conditional as if are two or one ENSEMBL gene ID associated to the NCBI gene ID
			if($ln =~ /(See related\: Ensembl:)(\w+\d+)\; Ensembl:(\w+\d+)/){
				$ENID = $2;
				$ENID2 = $3;
				#~ print "$1\t$2\n";
				print $finalfh "$GID\t$ENID\n";			# Print NCBI-ENSEMBL gene IDs equivalence in the output file
				print $finalfh "$GID\t$ENID2\n";		# Print NCBI-ENSEMBL gene IDs equivalence in the output file
			}elsif($ln =~ /(See related\: Ensembl:)(\w+\d+)/){
				$ENID = $2;
				#~ print "$1\t$2\n";
				print $finalfh "$GID\t$ENID\n";			# Print NCBI-ENSEMBL gene IDs equivalence in the output file
			}
		}
		close $fh2;	
		system "rm $gfile";				# Eliminates the NCBI gene report 		
	}
}
close $fh;
