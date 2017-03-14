#!/bin/bash -e
exports=/var/www/sites/oralhistory.uky.edu/versions/omeka-2.1.4/plugins/ExportSpokeJson/exports/
count=$(find $exports -type f | wc -l)
indexer="bash /home/rails/spoke2index/indexy.sh"
     
if [ "$count" -gt "0" ]; then
  $indexer
fi



