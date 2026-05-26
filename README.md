# tf-atom-s3-bucket-website-configuration-aws

[![CI](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-website-configuration-aws/actions/workflows/ci.yml/badge.svg)](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-website-configuration-aws/actions/workflows/ci.yml)
[![Release](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-website-configuration-aws/actions/workflows/auto-release.yml/badge.svg)](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-website-configuration-aws/actions/workflows/auto-release.yml)

---

## Purpose

Configures static website hosting for an S3 bucket with index/error documents and optional routing rules for redirects.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│           Molecule Layer                                    │
│  ┌──────────────┐    ┌──────────────────────────────┐      │
│  │ s3-bucket    │───▶│ THIS MODULE                  │      │
│  │ (bucket_id)  │    │ website-configuration        │      │
│  └──────────────┘    │ (index.html, error.html)     │      │
│                      └──────────────────────────────┘      │
│  ┌──────────────┐              ▲                           │
│  │ CloudFront   │──────────────┘ (optional CDN)            │
│  │ (external)   │                                          │
│  └──────────────┘                                          │
└─────────────────────────────────────────────────────────────┘
```

## Scope

| In Scope | Out of Scope |
|----------|--------------|
| `aws_s3_bucket_website_configuration` resource | Bucket creation (→ `tf-atom-s3-bucket-aws`) |
| Index and error document configuration | Public access block (→ `tf-atom-s3-bucket-public-access-block-aws`) |
| Routing rules for redirects | Bucket policy for public read (→ `tf-atom-s3-bucket-policy-aws`) |
| Conditional creation (`enabled`) | CloudFront distribution |

## Features

- **Single-resource atom** — one `aws_s3_bucket_website_configuration`
- **Sensible defaults** — `index.html` and `error.html` out of the box
- **Routing rules** — redirect support with conditions
- **Tested** — unit tests for defaults, disabled, and custom documents

## Usage

```hcl
module "website_config" {
  source = "github.com/PlatformStackPulse/tf-atom-s3-bucket-website-configuration-aws?ref=v1.0.0"

  context   = module.this.context
  bucket_id = module.bucket.bucket_id

  index_document = "index.html"
  error_document = "404.html"
}
```

## Module Documentation

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
