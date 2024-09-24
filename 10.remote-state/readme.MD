### remote-state

in contribution environment we dont maintain the state remotely there will be chances of duplicates and errors. so we keep the state in remote location so that terraform can effectively compare 

to store state remotely using aws S3, for locking dynamoDB

remote storage --> s3 bucket

locking --> dynamo DB --> LockID

*s3 : AWS > S3> create bucket > unique name > supra-remote-state >create 

*dynamoDB :  AWS > DynamoDB > Tables > create table > unique (table name) > supra-locking > partition key > LockID > create table

to create remote state "backend S3" code will be added in provider.tf

for ref :

https://developer.hashicorp.com/terraform/language/backend/s3

```
backend "s3" {
    bucket = "supra-remote-state"
    key    = "remote-state-demo"
    region = "us-east-1"
    dynamodb_table = "supra-locking"
  }
```
key name will be unique for every repo.

bucket and dynamoDB values are name of S3 bucket name and dynamoDB name

after ec2 instance created, lock file will be created under dynamodb,explore table items.
state file will be created under buckets
