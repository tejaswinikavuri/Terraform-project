resource "aws_iam_role" "role" {
  name = "role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
  Version = "2012-10-17",
  Statement = [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "autoscaling.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})

tags = {
key = "foo"
value = "bar"
propagate_at_launch = true
}
}