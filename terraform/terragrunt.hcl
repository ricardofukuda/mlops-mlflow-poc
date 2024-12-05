remote_state {
  backend = "s3"
  
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    key = "${path_relative_to_include()}/terraform.tfstate"
    bucket = "tf-fukuda-mlops-mlflow-demo"
    region = "us-east-1"
  }
}