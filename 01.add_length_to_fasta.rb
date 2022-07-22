
hlen={}
aa=File.open("contigs_length.txt").each_line do |line|
line.chomp!
hlen[line.split("\t")[0]]=line.split("\t")[1]
end
aa.close

`cp contigs_ARGs.fna contigs_ARGs2.fna`

out=File.new("contigs_ARGs.fna","w")

bb=File.open("contigs_ARGs2.fna").each_line do |line|
line.chomp!
if  line =~ /^>(\S+)/
out.puts ">#{$1}\_length_#{hlen[$1]}"
else out.puts line
end
end
bb.close

