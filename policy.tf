resource "aws_iam_policy" "ec2_policy" {
  name = "ec2_policy"
  path = "/"
  description = "Permissions for ec2 instance"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1675862921779",
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
})
}

resource "aws_iam_role" "ec2_role" {
    name = "ec2_role"

    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": ""
                "Action": "sts:AssumeRole"
                "Effect": "Allow"
                "Principal" = {
                    Service = "ec2.amazonaws.com"
                }
            },

        ]
    })  
}

resource "aws_iam_policy_attachment" "ec2_policy_role" {
  name = "ec2_attachment"
  roles = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = "${aws_iam_role.ec2_role.name}"
}