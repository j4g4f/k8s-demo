terraform {
    backend "s3" {
        encrypt         = true
        bucket          = "jg-learning-bucket"
        key             = "eks/terraform.tfstate"
        region          = "us-east-2"
        dynamodb_table  = "terraform-locks"
    }
    required_version = ">= 1.00"
}