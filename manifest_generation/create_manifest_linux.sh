#!/bin/sh
#This script creates a manifest for all files in a directory listing files and creation dates. 
#This manifest can then be used to upload data to SevenBridges using the sb upload command
#This script should be run from the upload directory. 
#Run this script using the command : bash create_manifest_linux.sh
#After running, files can be uploaded to SevenBridges using the command:
#	sb upload start --manifest-file manifest.csv --destination path/to/upload/directory/


find * -type f -printf '%p,%TY%Tm%Td \n' >> manifest.csv
(echo "filename,creation_date" && cat manifest.csv) > manifest2.csv
cat manifest2.csv > manifest.csv
rm manifest2.csv
