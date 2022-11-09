resource "aws_appautoscaling_target" "zoominfo-service1-target" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/zoominfo-ecs-fargate/zoominfo-service1"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "dev_to_memory" {
  name               = "dev-to-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.zoominfo-service1-target.resource_id
  scalable_dimension = aws_appautoscaling_target.zoominfo-service1-target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.zoominfo-service1-target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "dev_to_cpu" {
  name = "dev-to-cpu"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.zoominfo-service1-target.resource_id
  scalable_dimension = aws_appautoscaling_target.zoominfo-service1-target.scalable_dimension
  service_namespace = aws_appautoscaling_target.zoominfo-service1-target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}
