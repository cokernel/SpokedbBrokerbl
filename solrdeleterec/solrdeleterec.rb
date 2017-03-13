#!/usr/bin/env ruby

require 'rsolr'
require 'json'

solr = RSolr.connect :url => 'http://localhost:xxxx/solr/blacklight-core'

id = ARGV[0].gsub(/[^A-Za-z0-9_]/, '')
solr.delete_by_id id
solr.commit

