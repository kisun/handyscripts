Create MD5 checksums for all files within a directory and its subdirectories

> find /path/to/directory -type f -exec md5sum {} + > md5sums.txt
