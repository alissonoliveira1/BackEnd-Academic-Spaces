provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "this" {
  name = "espaco-academico-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "espaco-academico"
  container_definitions    = jsonencode([{
    name      = "Ubuntu-espaco"
    image     = "AMI"
    cpu       = 256
    memory    = 512
    essential = true
  }])
}

resource "aws_ecs_service" "this" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
}

output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
}

output "ecs_service_name" {
  value = aws_ecs_service.this.name
}