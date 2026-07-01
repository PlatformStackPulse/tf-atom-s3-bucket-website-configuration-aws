mock_provider "aws" {}

variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  bucket_id      = "eg-test-thing-bucket"
  index_document = "index.html"
  error_document = "error.html"
}

# When enabled, the website configuration resource is created with the
# provided bucket_id and index/error documents. Assertions target
# plan-known values (resource count, input pass-throughs, the enabled
# output) rather than computed attributes (website_endpoint / website_domain),
# which are unknown under a mock provider.
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = length(aws_s3_bucket_website_configuration.this) == 1
    error_message = "Exactly one website configuration should be created when enabled"
  }

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = aws_s3_bucket_website_configuration.this[0].bucket == "eg-test-thing-bucket"
    error_message = "bucket should pass through the provided bucket_id"
  }

  assert {
    condition     = aws_s3_bucket_website_configuration.this[0].index_document[0].suffix == "index.html"
    error_message = "index_document suffix should match the provided index_document"
  }
}

# Custom index and error documents are honoured.
run "supports_custom_documents" {
  command = plan

  variables {
    index_document = "home.html"
    error_document = "404.html"
  }

  assert {
    condition     = aws_s3_bucket_website_configuration.this[0].index_document[0].suffix == "home.html"
    error_message = "index_document suffix should honour the custom index_document"
  }

  assert {
    condition     = aws_s3_bucket_website_configuration.this[0].error_document[0].key == "404.html"
    error_message = "error_document key should honour the custom error_document"
  }
}

# When disabled, no resources are created and computed outputs are null.
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_s3_bucket_website_configuration.this) == 0
    error_message = "No website configuration should be created when disabled"
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output should be false when the module is disabled"
  }

  assert {
    condition     = output.website_endpoint == null
    error_message = "website_endpoint should be null when disabled"
  }
}
