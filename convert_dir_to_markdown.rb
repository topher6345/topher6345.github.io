filenames = Dir.entries("_posts/") - %w[. ..]

filenames.each do |f| 
	system("./html2markdown < _posts/#{f} > _posts/#{f}.tmp") 
end










