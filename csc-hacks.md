## some useful CSC hacks

#data sharing

module load allas
> allas-conf --mode S3

create new bucket
> s3cmd mb s3://my_bucket

upload files to bucket
> s3cmd put my_file s3://my_bucket

make the bucket public
> s3cmd setacl --acl-public s3://my_bucket

make the files inside bucket public
> s3cmd setacl --acl-public s3://my_bucket/my_file

The url of the file will be: 
> https://a3s.fi/my_bucket/my_file

