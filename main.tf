################################################################################################################
## Configure the bucket and static website hosting
################################################################################################################
resource "aws_s3_bucket" "website_bucket" {
  acl       = "private"
  bucket    = "${var.bucket_name}"
  region    = "${var.region}"

  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
  }

  tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.bucket_name}", "Environment", "${var.environment}", "Project", "${var.project}"))}"
}

## AWS only supports a single bucket policy on a bucket. You can combine multiple Statements into a single policy, but not attach multiple policies.
# https://github.com/hashicorp/terraform/issues/10543
resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  policy = "${data.aws_iam_policy_document.website_policy.json}"
}

data "aws_iam_policy_document" "website_policy" {
  statement = [{
    actions   = ["s3:GetObject"]

    condition {
      test      = "StringEquals"
      variable  = "aws:UserAgent"
      values    = ["${var.duplicate_content_penalty_secret}"]
    }

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]
  }]
}
