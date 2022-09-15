#create the role
resource "aws_iam_role" "artifactory" {
  name = "artifactory-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "artifactory"
  }
}

#create policy

resource "aws_iam_policy" "artifactory" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
})
}

#attach policy
resource "aws_iam_role_policy_attachment" "artifactory" {
  role       = aws_iam_role.artifactory.name
  policy_arn = aws_iam_policy.artifactory.arn
}

#role to ec2
resource "aws_iam_instance_profile" "artifactory" {
  name = "test_profile"
  role = aws_iam_role.artifactory.name
}