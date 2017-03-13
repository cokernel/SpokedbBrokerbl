#!/usr/bin/env ruby

require 'rsolr'
require 'json'
require 'fileutils'

origin = '/home/rails/spoke2index/index/2index'
destination = '/home/rails/spoke2index/done'

solr = RSolr.connect :url => 'http://localhost:xxxx/solr/blacklight-core'

Dir.chdir('/home/rails/spoke2index/index/2index/')

# check if data is there and die if there is none

if Dir["/home/rails/spoke2index/index/2index/*"].empty?
     puts "Nothing to index"
     exit 0
end

# process data

     Dir.glob('*.json').each do |file|
	puts "Indexing #{file}"


		#Index all JSON files.  
		doc = JSON.parse(IO.read(file), :symbolize_names => true)
		if doc.has_key? :related_series_display
		  series = doc[:related_series_display].collect do |item|
		    item.to_json
		  end
		  doc[:related_series_display] = series
		end
		solr.add doc
		solr.commit
end

if Dir["/home/rails/spoke2index/index/2index/*"].empty?
     puts "Nothing to move"
     exit 0
end

Dir.glob(File.join(origin, '*')).each do |file|
    FileUtils.move file, File.join(destination, File.basename(file))
end




