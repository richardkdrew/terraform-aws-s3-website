# terraform-aws-s3-website
Terraform module for creating S3 backed websites

## Usage

#### Create s3 website bucket

```hcl
module "website" {
  source                            = "git::https://github.com/richardkdrew/terraform-aws-s3-website.git?ref=master"

  bucket_name                       = "${var.domain}"
  duplicate_content_penalty_secret  = "${var.duplicate_content_penalty_secret}"
  environment                       = "${var.environment}"
  project                           = "${var.project}"
  region                            = "${var.region}"
}
```

## Variables

|  Name                              |  Default       |  Description                                                                        |  Required |
|:-----------------------------------|:--------------:|:------------------------------------------------------------------------------------|:---------:|
|  `bucket_name`                     |  ``            |  The domain name for the website being hosted                                       |  Yes      |
|  `duplicate_content_penalty_secret`|  ``            |  Secret/password used to restrict access to S3                                      |  Yes      |
|  `environment`                     |  `default`     |  The label for the environment. Used for naming/tagging purposes                    |  No       |
|  `error_document`                  |  `index.html`  |  An absolute path to the document to return in case of a 4XX error                  |  No       |
|  `index_document`                  |  `index.html`  |  The document to return when requests are made to the root domain or sub-folders    |  No       |
|  `project`                         |  `noproject`   |  The label for the project. Used for naming/tagging purposes                        |  No       |
|  `region`                          |  ``            |  e.g. eu-central-1                                                                  |  Yes      |
|  `tags`                            |  `[]`          |  Optional Tags                                                                      |  No       |

The label for the project. Used for naming/tagging purposes

## Outputs

| Name                           | Description                                                 |
|:------------------------------ |:------------------------------------------------------------|
| `s3_website_bucket_name`       | Name of the website bucket                                  |
| `s3_website_bucket_domain_name`| Domain name (DNS-record) of the website bucket              |

## Further Reading

* Website Hosting (Custom Domain) http://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html

* Bucket Name Restrictions:
http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html

* Duplicate Content Penalty protection:
  * Description: https://support.google.com/webmasters/answer/66359?hl=en
  * Solution: http://tuts.emrealadag.com/post/cloudfront-cdn-for-s3-static-web-hosting/
    * Section: Restricting S3 access to Cloudfront
