<?php

$DIR = "/home/rails/spoke2index/index/work/*.json";

// Open a known directory, and proceed to read its contents  
foreach(glob($DIR) as $REC_PATH)  
{  
// file_get_contents
$str = file_get_contents("$REC_PATH");

// check for interview level JSON records
if (preg_match('/interview/',$str)) {

// decode JSON
$json = json_decode($str, true);

// get the data
$id = $json['id'];
$accession = $json['accession_number_display'];

// run XML parser on cachefile to generate fulltext and add it to JSON file
shell_exec("bash /home/rails/spoke2index/spoke2txt.sh $accession $id");
}
}
