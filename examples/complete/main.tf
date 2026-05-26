provider "aws" {
  region = "eu-west-2"
}

module "s3_website" {
  source = "../../"

  namespace   = "psp"
  environment = "dev"
  name        = "docs"

  bucket_id      = "psp-dev-docs"
  index_document = "index.html"
  error_document = "404.html"
}

output "website_endpoint" {
  value = module.s3_website.website_endpoint
}
