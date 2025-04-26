provider "aws" {

}

resource "aws_ecs_cluster" "this" {

  name = "espaco-academico-cluster"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "espaco-academico"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
          "iam:CreateRole",
          "iam:PutRolePolicy",
          "iam:GetRole",
          "iam:ListRolePolicies",
          "iam:DeleteRolePolicy",
          "iam:DeleteRole"
        ],
        "Resource": "arn:aws:iam::aws:policy/AWSPriceListServiceFullAccess"
      }

    ]
    Statement = [ //AWS Simulate-principal-policy
      {
        "Effect": "Allow",
        "Action": "iam:SimulatePrincipalPolicy",
        "Resource": "arn:aws:iam::aws:policy/aws-service-role/AmazonECSServiceRolePolicy"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/aws-service-role/AmazonECSServiceRolePolicy"
}

