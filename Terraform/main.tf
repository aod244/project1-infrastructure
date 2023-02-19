provider "aws" {
  region = "us-west-2"
}

# Define the S3 bucket to store the app
resource "aws_s3_bucket" "example" {
  bucket = "my-flask-app-bucket"

  # Enable versioning to track changes to the app
  versioning {
    enabled = true
  }
}

# Define a local file to upload to the bucket (in this case, the Flask app)
resource "local_file" "app" {
  filename = "./simpleflaskapp.py"
  content  = file("${path.module}/simpleflaskapp.py")
}

# Upload the app file to the bucket
resource "aws_s3_bucket_object" "app" {
  bucket = "${aws_s3_bucket.example.bucket}"
  key    = "app.py"
  source = "${local_file.app.filename}"
}