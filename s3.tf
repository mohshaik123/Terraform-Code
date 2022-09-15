resource "aws_s3_bucket" "cicd_bucket" {

    bucket = "artifactory-for-cicd-flow"
    tags = {
    Name = "artifactory-for-cicd-flow"
  }
  
}