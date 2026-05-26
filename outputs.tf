output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "website_endpoint" {
  description = "Website endpoint URL"
  value       = try(aws_s3_bucket_website_configuration.this[0].website_endpoint, null)
}

output "website_domain" {
  description = "Website domain"
  value       = try(aws_s3_bucket_website_configuration.this[0].website_domain, null)
}
