# SevenBridges Manifest Creation Tool

This script creates a manifest to upload files to Seven Bridges for all files in a directory (and sub-directories). The manifest will list all files and their creation date that will be listed in the meta-data on Seven Bridges.

This script should be run from the directory that will be uploaded.

Run the script using the command:
    `bash create_manifest.sh`

This will create a file `manifest.csv` within the directory. 

After running, files can be uploaded to Seven Bridges with the sb cli using the command:

`sb upload start --manifest-file manifest.csv --destination path/to/upload/directory/`


For any questions regarding this tool, contact Caryn Willis, cdwillis@rti.org. 
