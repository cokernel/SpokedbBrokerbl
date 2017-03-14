#!/bin/bash

# get variables from external input
accession="$1"
ark="$2"

# setting paths to cachefiles and json files for SPOKEdb
CACHE=/opt/shares/spoke/cache
JSON=/home/rails/spoke2index/index/work
ADDS=/home/rails/spoke2index/index/addons
IDX=/home/rails/spoke2index/index/2index
OMEKA=/home/rails/spoke2index/index/omeka

filename=${accession}_ohm.xml

# setting variable for cachefile
f=$CACHE/$filename

FILE=$f
if [ -f $FILE ]; then

# parse XML cachefile and set variables
index=$(xml_grep 'index' $f --text_only)
transcript=$(xml_grep 'transcript' $f --text_only)

# add fulltext to JSON file using replace
cp $JSON/$ark.json $IDX/$ark.json
mv $JSON/$ark.json $OMEKA/$ark.json
sed -i '1s/^.//' $IDX/$ark.json
echo "$index $transcript" | tr -cs '[:print:]' ' ' | perl -pe 's/[^a-zA-Z0-9]/ /g and s/\n/ /g' > $IDX/$accession.json
paste $ADDS/start.txt $IDX/$accession.json $ADDS/end.txt $IDX/$ark.json | sed 's/\t/ /' > $IDX/$ark.txt
sed -i 's/",	"id"/","id"/g' $IDX/$ark.txt
sed -i 's/   	","id"/","id"/g' $IDX/$ark.txt
sed -i 's/ 	","id"/","id"/g' $IDX/$ark.txt
sed -i 's/   	","id"/","id"/g' $IDX/$ark.txt
sed -i 's/ 	","id"/","id"/g' $IDX/$ark.txt
rm $IDX/$accession.json
mv $IDX/$ark.txt $IDX/$ark.json

# index files
echo adding full-text and indexing 
ruby /home/rails/json2index/json2index.rb

else

# index files 
echo just indexing this file
cp $JSON/$ark.json $IDX/$ark.json
ruby /home/rails/json2index/json2index.rb

fi
