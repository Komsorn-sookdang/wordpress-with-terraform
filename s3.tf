resource "aws_s3_bucket" "wordpress-bucket" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "wordpress-access-block" {
    bucket = aws_s3_bucket.wordpress-bucket.id

    block_public_acls       = false
    ignore_public_acls      = false
    block_public_policy     = true
    restrict_public_buckets = true
}

resource "aws_iam_user" "user" {
    name = "wp-bucket-user"
}

resource "aws_iam_user_policy" "wordpress-bucket-user-policy" {
    name = "wp-policy"
    user = aws_iam_user.user.name

    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": [
                    "s3:PutObject",
                    "s3:GetObjectAcl",
                    "s3:GetObject",
                    "s3:PutBucketAcl",
                    "s3:ListBucket",
                    "s3:DeleteObject",
                    "s3:GetBucketAcl",
                    "s3:GetBucketLocation",
                    "s3:PutObjectAcl"
                ],
                "Resource": [
                    "arn:aws:s3:::${var.bucket_name}",
                    "arn:aws:s3:::${var.bucket_name}/*"
                ]
            }
        ]
    })
}

resource "aws_iam_access_key" "s3_key" {
    user = aws_iam_user.user.name
}