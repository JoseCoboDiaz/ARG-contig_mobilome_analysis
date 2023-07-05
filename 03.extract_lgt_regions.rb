
out1=File.new("lgt_inserted_positions.txt","w")
out2=File.new("lgt_inserted_positions_AxxA.txt","w")
out3=File.new("lgt_positions.txt","w")
hcoord={}

out1.puts "Contig\tCoordenates\tclade_A\tclade_B"
out2.puts "Contig\tCoordenates\tclade_A\tclade_B"


aa=File.open("waafle_contigs/contigs_ARGs.lgt.tsv").each_line do |line|
line.chomp!
#7673_Egypt65_NODE_14_length_4567_cov_3.67725	lgt	4567	0.9004	0.9513	ABBB	A?B	s__Campylobacter_coli	s__Campylobacter_jejuni	g__Campylobacter	--	--	r__Root|k__Bacteria|p__Proteobacteria|c__Epsilonproteobacteria|o__Campylobacterales|f__Campylobacteraceae|g__Campylobacter|s__Campylobacter_coli	r__Root|k__Bacteria|p__Proteobacteria|c__Epsilonproteobacteria|o__Campylobacterales|f__Campylobacteraceae|g__Campylobacter|s__Campylobacter_jejuni	384:1420:+|1396:1848:+|2125:2439:+|2486:3736:+	UniRef50_W8K5B8|UniRef50_H7Z7R2|UniRef50_H7Z6K8|UniRef50_H7Y4Z6	UniRef90_W8K5B8|UniRef90_H7Z7R2|UniRef90_H7Z6K8|UniRef90_H7Z6K9
contig=line.split("\t")[0]
sinteny=line.split("\t")[5]	#AAAB*AAAAAA
cladea=line.split("\t")[7]
cladeb=line.split("\t")[8]
lca=line.split("\t")[9]		#lowest commun ancester
coordenates=line.split("\t")[14]

#sinteny.split("").length == coordenates.split("\|").length
sinteny.split("").each_index {|x| if sinteny.split("")[x]=="B" or sinteny.split("")[x]=="*"
			hcoord[contig]=coordenates.split("\|")[x]
			out1.puts "#{contig}\_#{x}\t#{coordenates.split("\|")[x]}\t#{cladea}\t#{cladeb}"
			out3.puts "#{contig}\t#{coordenates.split("\|")[x].split("\:")[0]}\t#{coordenates.split("\|")[x].split("\:")[1]}"
			end
}

if sinteny.split("")[0]==sinteny.split("")[-1]

sinteny.split("").each_index {|x| if sinteny.split("")[x]=="B" or sinteny.split("")[x]=="*"
			hcoord[contig]=coordenates.split("\|")[x]
			out2.puts "#{contig}\_#{x}\t#{coordenates.split("\|")[x]}\t#{cladea}\t#{cladeb}"
#			out3.puts "#{contig}\t#{coordenates.split("\|")[x].split("\:")[0]}\t#{coordenates.split("\|")[x].split("\:")[1]}"
			end
}
end

end
aa.close
