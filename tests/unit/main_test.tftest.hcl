mock_provider "aws" {}

run "creates_website_config_with_defaults" {
  variables {
    name        = "test"
    environment = "dev"
    namespace   = "unit"
    bucket_id   = "my-test-bucket"
  }

  assert {
    condition     = output.website_endpoint != null
    error_message = "website_endpoint should not be null when enabled"
  }
}

run "creates_nothing_when_disabled" {
  variables {
    name        = "test"
    environment = "dev"
    namespace   = "unit"
    enabled     = false
    bucket_id   = "my-test-bucket"
  }

  assert {
    condition     = length(aws_s3_bucket_website_configuration.this) == 0
    error_message = "No resource should be created when disabled"
  }
}

run "supports_custom_documents" {
  variables {
    name           = "test"
    environment    = "dev"
    namespace      = "unit"
    bucket_id      = "my-test-bucket"
    index_document = "home.html"
    error_document = "404.html"
  }

  assert {
    condition     = output.website_endpoint != null
    error_message = "Should create website config with custom documents"
  }
}
