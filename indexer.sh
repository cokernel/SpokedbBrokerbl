#!/bin/bash         

# setting variables
SPOKE=/var/www/sites/oralhistory.uky.edu/versions/current/plugins/ExportSpokeJson/exports
MOVE=/home/rails/spoke2index/index/work
JSON=/home/rails/spoke2index/index/work
OMEKA=/home/rails/spoke2index/index/omeka

# move files from spoke export directory to the index directory
mv $SPOKE/*.json $MOVE

# index files 
# ruby /home/rails/json2index/json2index.rb

# run fulltext extraction and indexing
php /home/rails/spoke2index/spoke_extract.php

# move non online files from spoke export directory to the omeka directory
mv $JSON/*.json $OMEKA
