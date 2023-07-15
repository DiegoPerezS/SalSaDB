#!/usr/bin/perl
########################################################################
#
#	This script was created by Diego Pérez-Stuardo
#	Files needed to run this script: genome GFF file from NCBI
#	It is needed to execute the "unique" function in R to obtain a
#		non-redundant dataset
#
########################################################################

use strict;
use warnings;

#	Directory that contains the source file
my $in_dir = "../Genome/Salmo_salar-information/GCF_905237065.1";
#	GFF file name
my $gff = "genomic.gff";
#	Output file
my $newfile = "NCBI_list.txt";

#------Declarations-------
my $file = "$in_dir/$gff"; 	#	Indicate where the gff file using the previous folder and files declarations
my $GID = "";				#	Empty, to save the NCBI GID
my $class = "";				#	Empty, to save the class of the sequence in case it is needed to filter by class (mRNA, ncRNA, tRNA, etc)

#	Open the new file
system "touch $newfile";
open (my $finalfh, '>', $newfile) or die "Can't open '$file' $!\n";
print $finalfh "NCBI_GID\tcheck\n";

#	 Open the input file and read line by line
open (my $fh, '<', $file) or die "Can't open '$file' $!\n";
while (my $line = <$fh>){
	chomp $line;
	#	Select GeneID information from gff
	if($line =~ /^(\w+_\d+\W\d)\s+(\w+)\s+(\w+).+GeneID\W(\d+)/){
		#	Depuration code
		#~ print "$1\t$2\t$3\t$4\n";
		#~ $class = $3;
		$GID = $4;
		print $finalfh "$GID\tgood\n"
		#	Depuration code
		#~ print "$class\n";
		#	Filter data by sequence class
		#~ if ($class =~ "mRNA"){
			#~ print "$class\t$GID\n";
			#~ print "$GID\tgood\n";
		#~ }
	}
}
close $fh;
