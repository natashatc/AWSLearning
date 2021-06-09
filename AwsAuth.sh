
#!/bin/bash
echo Hello, Please enter your AWS account number
read accountnumber
echo Please enter your AWS access Key ID
read accessid
echo Please enter your secret access key
read secretkey
echo Please enter your default region
read region
DATE=$(date +%Y-%m-%d --date '60 days ago')


aws configure

export AWS_ACCESS_KEY_ID=$accessid
export AWS_SECRET_ACCESS_KEY=$secretkey
export AWS_DEFAULT_REGION=$region

aws ec2 describe-images --filters Name=image-type,Values=machine Name=is-public,Values=false Name=owner-id,Values=$accountnumber \
                        --query 'Images[?CreationDate<`'$DATE'`] | sort_by(@, &CreationDate)[].Name'
