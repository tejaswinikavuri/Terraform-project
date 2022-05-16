# Create a bucket
resource "aws_s3_bucket" "b1" {
bucket = "s3-terraform-bucket-lab-new"
acl    = "private"   # or can be "public-read"
tags = {
Name        = "My bucket"
Environment = "Dev"
}
}

# Upload an object
resource "aws_s3_bucket_object" "object" {
bucket = aws_s3_bucket.b1.id
key    = "profile"
acl    = "private"  # or can be "public-read"
source = "C:/Users/TEJA/Documents/myfiles/file.jpg"
etag = filemd5("C:/Users/TEJA/Documents/myfiles/file.jpg")
}