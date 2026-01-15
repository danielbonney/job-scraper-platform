provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "job_scraper_data" {
  bucket = "dbonney-job-scraper-data"

  tags = {
    Name        = "Job Scraper Data"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.job_scraper_data.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.job_scraper_data.id
  acl    = "private"
}
