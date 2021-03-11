
out1=File.new("protintegron_position.txt","w")
out2=File.new("integrasa_position.txt","w")

cols=''

cc=File.open("Results_Integron_Finder_contigs_ARGs/contigs_ARGs.integrons").each_line do |line|
line.chomp!
#ID_integron	ID_replicon	element	pos_beg	pos_end	strand	evalue	type_elt	annotation	model	type	default	distance_2attC	considered_topology
#integron_01	AMBIENTE_0H_S107_contig-120_852	AMBIENTE_0H_S107_contig-120_852_2	845	1636	-1	2e-26	protein	intI	intersection_tyr_intI	In0	Yes	NA	lin
cols=line.split("\t")
#because sometimes integron_finder predicts proteins higher that contig:
if cols[3].to_i<1
cols[3]=1
end
#integron_01	ANP_149_NODE_399_length_10248_cov_11.192877
	if line =~ /length_(\d+)/
	if $1.to_i < cols[4].to_i
	cols[4]=$1
	end
	end
###
if cols[8] =~ /protein/ or cols[8] =~ /attC/ 
	out1.puts "#{cols[1]}\t#{cols[3]}\t#{cols[4]}"
elsif cols[8] =~ /intI/
	out2.puts "#{cols[1]}\t#{cols[3]}\t#{cols[4]}"
end
end
cc.close

