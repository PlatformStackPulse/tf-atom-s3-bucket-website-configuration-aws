variable "bucket_id" {
  description = "ID (name) of the S3 bucket to configure as a website"
  type        = string
}

variable "index_document" {
  description = "Name of the index document (e.g. index.html)"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Name of the error document (e.g. error.html). Set to null to disable."
  type        = string
  default     = "error.html"
}

variable "routing_rules" {
  description = "List of routing rules for redirects"
  type = list(object({
    condition = optional(object({
      http_error_code_returned_equals = optional(string, null)
      key_prefix_equals               = optional(string, null)
    }), null)
    redirect = object({
      host_name               = optional(string, null)
      http_redirect_code      = optional(string, null)
      protocol                = optional(string, null)
      replace_key_prefix_with = optional(string, null)
      replace_key_with        = optional(string, null)
    })
  }))
  default = []
}
