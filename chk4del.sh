#!/bin/bash -e
exports=/var/www/sites/oralhistory.uky.edu/versions/omeka-2.1.4/plugins/ExportSpokeJson/deletes/
count=$(find $exports -type f | wc -l)
indexer="php /home/rails/spoke2del/deleter.php"
     
if [ "$count" -gt "0" ]; then
  $indexer
fi


