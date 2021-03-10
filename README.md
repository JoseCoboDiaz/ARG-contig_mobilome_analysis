# ARG-contig_mobilome_analysis
This pipeline performs a mobilome analyses on previously selected contigs, those harboring antimicrobial genes from ResFinder database (https://bitbucket.org/genomicepidemiology/resfinder_db/downloads/), to confirm or discard the location of such genes within plasmid or chromosomal, or even within integron or lateral gene transfer (lgt) regions. It can be adapted to other purposes (databases), according to user requeriments.

Blast need to be installed (http://www.metagenomics.wiki/tools/blast/installhttp://www.metagenomics.wiki/tools/blast/install) and the ResFinder database has to be transformed to blast-format by:

<i>cat resfinder_db/*.fsa > resfinder.fasta</i>

<i>makeblastdb -in resfinder.fasta -dbtype nucl -out ResFinder</i>

If the contigs has not the metaSPAdes header format (>samplename_NODE_XXX_length_XX_cov_XX.XX) it is necessary to add contig-length information on fasta headers for further steps, using bioawk tools (https://github.com/lh3/bioawk) by:

<i>bioawk -c fastx '{ print $name, length($seq) }' < contigs_ARGs.fna > contigs_length.txt</i>
  
<i>ruby 01.add_length_to_fasta.rb</i>

being contigs_ARGs.fna the input file.

The integron_Finder (https://github.com/gem-pasteur/Integron_Finder), plasflow (https://github.com/smaegol/PlasFlow) and waafle (https://github.com/biobakery/waafle) softwares have to been installed, and they will be run on the contigs_ARGs.fna file by:

<i>source ~/Integron_Finder/bin/activate</i>

<i>integron_finder --cpu 10 contigs_ARGs.fna</i>


<i>conda activate plasflow</i>

<i>mkdir plasflow_contigs</i>

<i>PlasFlow.py --input contigs_ARGs.fna --output plasflow_contigs/plasflow.csv</i>

<i>rm plasflow_contigs/*.fasta</i>


<i>mkdir waafle_contigs</i>

<i>waafle_search --threads 11 --out waafle_contigs/blast.txt contigs_ARGs.fna ~/waafledb</i>

<i>waafle_genecaller --gff waafle_contigs/genecall.gff waafle_contigs/blast.txt</i>

<i>waafle_orgscorer --outdir waafle_contigs/ contigs_ARGs.fna waafle_contigs/blast.txt waafle_contigs/genecall.gff ~/waafledb_taxonomy.tsv</i>

<i>rm waafle_contigs/blast.txt</i>

<i>rm waafle_contigs/genecall.gff</i>


where the ~/ has to be substituted by the correct pathway to waafledb folder and waafledb_taxonomy.tsv file.

And the following scripts are employed to obtain the integrons and lgts regions coordenates within the contigs, and to extract this regions in fasta file and blast them versus ResFinder database (previously transformed to blastdb format): 

<i>ruby 02.extract_integron_regions.rb</i>

<i>ruby 03.extract_lgt_regions.rb</i>
