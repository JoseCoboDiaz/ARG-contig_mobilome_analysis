
hlen={}
aa=File.open("contig_length.txt").each_line do |line|
line.chomp!
hlen[line.split("\t")[0]]=line.split("\t")[1]
end
aa.close

`cp Results_Integron_Finder_contigs_ARGs/contigs_ARGs.integrons Results_Integron_Finder_contigs_ARGs/contigs_ARGs.integrons_old`

out=File.new("Results_Integron_Finder_contigs_ARGs/contigs_ARGs.integrons","w")

bb=File.open("Results_Integron_Finder_contigs_ARGs/contigs_ARGs.integrons_old").each_line do |line|
line.chomp!
if line =~ /ID_replicon/	# to keep the header line
out.puts line
elsif  line =~ /^(\S+\s+)(\S+)(\s+\S+.*)/
out.puts "#{$1}#{$2}\_length_#{hlen[$2]}#{$3}"
end
end
bb.close

