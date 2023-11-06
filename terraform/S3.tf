#Create kmskey
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
#Create S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = "myawsbucket36455"

  tags = {
    Name        = "My bucket"
    Environment = "Development"
  }
}
#Configure encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
#Block all public access
resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}