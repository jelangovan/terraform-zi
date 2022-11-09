resource "aws_ecs_cluster" "main" {
  name = "zoominfo-ecs-fargate"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "zoominfo-service1" {
  name            = "zoominfo-service1"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.zoominfo-service1.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"
    
  network_configuration {
    security_groups = [aws_security_group.zoominfo_task.id]
    subnets         = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.zoominfo-service1.id
    container_name   = "zoominfo-service1"
    container_port   = 5000
  }

  depends_on = [aws_lb_listener.zoominfo-service1]
}

resource "aws_ecs_service" "zoominfo-service2" {
  name            = "zoominfo-service2"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.zoominfo-service2.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  
  network_configuration {
    security_groups = [aws_security_group.zoominfo_task.id]
    subnets         = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.zoominfo-service2.id
    container_name   = "zoominfo-service2"
    container_port   = 5000
  }

  depends_on = [aws_lb_listener.zoominfo-service2]
}