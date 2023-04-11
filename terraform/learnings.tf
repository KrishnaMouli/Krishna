resource "aws_iam_policy" "policy3" {
  count       = var.resource == "lambda" || var.resource == "ec2" ? 1 : 0
  name        = "test_policy3"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#######################################################

variable "instance_type" {
  type = map
  default = {
    "master"  = "t2.medium"
    "slave" = "t2.micro"
  }
}

variable "type" {
  description = "The type of instance to start"
  type        = string
  default     = "master"
}

instance_type          = var.instance_type["${var.type}"]

###########################################################
