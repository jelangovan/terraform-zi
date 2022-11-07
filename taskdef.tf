resource "aws_ecs_task_definition" "zoominfo-service1" {
  family                   = "zoominfo-service1"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = "arn:aws:iam::820774903764:role/ecsTaskExecutionRole"
  container_definitions = <<DEFINITION
[
  {
    "image": "820774903764.dkr.ecr.eu-west-1.amazonaws.com/zoominfo-service1:latest",
    "cpu": 512,
    "memory": 1024,
    "name": "zoominfo-service1",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ]
  }
]
DEFINITION
}


resource "aws_ecs_task_definition" "zoominfo-service2" {
  family                   = "zoominfo-service2"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = "arn:aws:iam::820774903764:role/ecsTaskExecutionRole"
  container_definitions = <<DEFINITION
[
  {
    "image": "820774903764.dkr.ecr.eu-west-1.amazonaws.com/zoominfo-service2:latest",
    "cpu": 512,
    "memory": 1024,
    "name": "zoominfo-service2",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ]
  }
]
DEFINITION
}