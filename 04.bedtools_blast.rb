
#lgt_positions.txt 
#protintegron_position.txt 
#integrasa_position.txt

`bedtools getfasta -fi contigs_ARGs.fasta -bed lgt_positions.txt -fo lgt_genes.fasta`
`bedtools getfasta -fi contigs_ARGs.fasta -bed protintegron_position.txt -fo intprot_genes.fasta`
`bedtools getfasta -fi contigs_ARGs.fasta -bed integrasa_position.txt -fo integrasa.fasta`

`blastn -query lgt_genes.fasta -db ResFinder -out blastn_lgt_genes.txt -outfmt 6 -max_target_seqs 1 -num_threads 12`
`blastn -query intprot_genes.fasta -db ResFinder -out blastn_int_genes.txt -outfmt 6 -max_target_seqs 1 -num_threads 12`
