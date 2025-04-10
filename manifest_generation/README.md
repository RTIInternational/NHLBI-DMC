# SevenBridges Manifest Creation Tool

These scripts create a manifest to upload files to Seven Bridges for all files in a directory (and sub-directories). The manifest will list all files and their creation date that will be listed in the meta-data on Seven Bridges.

There is one script for Unix (Mac) systems (`creat_manifest_unix.sh`) and one script for linux (PCs, servers, etc.) systems (`create_manifest_linux.sh`. Use the script based on the system you are running it on. This script should be run from the directory that will be uploaded.

Run the script using the command:
    `bash create_manifest_linux.sh`

This will create a file `manifest.csv` within the directory. 

After running, files can be uploaded to Seven Bridges with the sb cli using the command:

`sb upload start --manifest-file manifest.csv --destination path/to/upload/directory/`


For any questions regarding this tool, contact Caryn Willis, cdwillis@rti.org. 
